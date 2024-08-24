SHELL := /bin/bash

REQUIRED_ENV_VARS := AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY

check_shell:
	@for var in $(REQUIRED_ENV_VARS); do \
		if [ -z "$${!var}" ]; then \
			echo "Error: $$var is not set"; \
			exit 1; \
		else \
			echo "$$var is set"; \
		fi \
	done
	@echo "All required environment variables are set."

check_virtualenv:
	@echo "Checking if virtualenv is installed..."
	@command -v virtualenv >/dev/null 2>&1 || \
		{ echo >&2 "virtualenv not found. Installing..."; python3 -m pip install --user virtualenv; }

create_venv: check_virtualenv
	@echo "Creating virtual environment..."
	@virtualenv venv

install_deps: create_venv
	@echo "Activating virtual environment and installing dependencies..."
	@. venv/local/bin/activate && pip install -r scripts/requirements.txt

render: check_shell install_deps
	@python3 scripts/render.py

build: check-shell render
	@terraform -chdir=terraform init
	@terraform -chdir=terraform plan -out=terraform.tfplan
	@terraform -chdir=terraform apply terraform.tfplan

plan: check_shell render
	@terraform -chdir=terraform init
	@terraform -chdir=terraform plan

configure: install_deps
	@ansible-galaxy install -r ansible/requirements.yaml
	@ansible-playbook ansible/bootstrap.yaml

deploy: build configure
	@echo "Set this to provide cluster information"

destroy: check_shell render
	@terraform -chdir=terraform destroy
	@echo "Destroy"

help:
	@echo "Usage: make [target]"
	@echo
	@echo "Available targets:"
	@echo "  check_shell             Check if required environment variables are set."
	@echo "  build                   Run Terraform init, plan, and apply commands."
	@echo "  plan                    Run Terraform init and plan commands."
	@echo "  configure               Run Ansible playbook for configuration."
	@echo "  deploy                  Run build and configure targets."
	@echo "  destroy                 Destroy the infrastructure created by Terraform."
	@echo "  help                    Display this help message."
