SHELL := /bin/bash

REQUIRED_ENV_VARS := AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
REQUIRED_PYTHON_PACKAGES := openshift kubernetes ansible

check-shell:
	@for var in $(REQUIRED_ENV_VARS); do \
		if [ -z "$${!var}" ]; then \
			echo "Error: $$var is not set"; \
			exit 1; \
		else \
			echo "$$var is set"; \
		fi \
	done
	@echo "All required environment variables are set."

check-python-packages:
	@for pkg in $(REQUIRED_PYTHON_PACKAGES); do \
		if ! python3 -c "import $$pkg" &> /dev/null; then \
			echo "Error: Python package $$pkg is not installed."; \
			exit 1; \
		else \
			echo "Python package $$pkg is available."; \
		fi \
	done
	@echo "All required Python packages are installed."

build: check-shell
	@terraform -chdir=terraform init
	@terraform -chdir=terraform plan -out=terraform.tfplan
	@terraform -chdir=terraform apply terraform.tfplan

plan: check-shell
	@terraform -chdir=terraform init
	@terraform -chdir=terraform plan

configure: check-python-packages
	@ansible-playbook ansible/bootstrap.yaml
	@echo configure

deploy: build configure
	@echo "Set this to provide cluster information"

destroy:
	@terraform -chdir=terraform destroy
	@echo "Destroy"
