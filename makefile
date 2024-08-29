SHELL := /bin/bash

REQUIRED_ENV_VARS := AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY

check_os:
	@if [ -f /.dockerenv ] || [ -f /run/.containerenv ] || grep -q 'container=' /proc/1/environ; then \
		echo "Running in container"; \
		echo "Hostname: $$(hostname)" && echo; \
		cat /etc/os-release && echo; \
	else \
		echo "Not running inside a container"; \
	fi

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

install_dependencies:
	@python3 -m pip install --no-cache-dir -r scripts/requirements.txt

render_templates: check_shell install_dependencies
	@python3 scripts/render.py

terraform_apply: check_shell render_templates
	@terraform -chdir=terraform init
	@terraform -chdir=terraform plan -out=terraform.tfplan
	@terraform -chdir=terraform apply terraform.tfplan

terraform_plan: check_shell render_templates
	@terraform -chdir=terraform init
	@terraform -chdir=terraform plan

ansible_setup: render_templates
	@ansible-galaxy install -r ansible/requirements.yaml --force
	@ansible-playbook ansible/bootstrap.yaml

terraform_destroy: check_shell render_templates
	@terraform -chdir=terraform destroy

podman_test:
	@podman run --rm -it \
		-v $(shell pwd)/:/usr/src/app:z \
		-w /usr/src/app \
		-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
		docker.io/cengleby86/bootstrapper:latest \
		bash -c "make check_os && make check_os"

podman_deploy:
	@podman run --rm -it \
		-v $(shell pwd)/:/usr/src/app:z \
		-w /usr/src/app \
		-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
		docker.io/cengleby86/bootstrapper:latest \
		bash -c "make check_os && make terraform_apply && make ansible_setup"

podman_destroy:
	@podman run --rm -it \
		-v $(shell pwd)/:/usr/src/app:z \
		-w /usr/src/app \
		-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
		docker.io/cengleby86/bootstrapper:latest \
		bash -c "make check_os && make terraform_destroy"

podman_configure:
	@podman run --rm -it \
		-v $(shell pwd)/:/usr/src/app:z \
		-w /usr/src/app \
		-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
		docker.io/cengleby86/bootstrapper:latest \
		bash -c "make check_os && make ansible_setup"

help:
	@echo "Usage: make [target]"
	@echo
	@echo "Available targets:"
	@echo "  check_env               Check if required environment variables are set."
	@echo "  terraform_apply         Run Terraform init, plan, and apply commands."
	@echo "  terraform_plan          Run Terraform init and plan commands."
	@echo "  ansible_setup           Run Ansible playbook for configuration."
	@echo "  podman_deploy           Run Terraform apply and Ansible setup in a Podman container."
	@echo "  podman_destroy          Destroy infrastructure using Terraform in a Podman container."
	@echo "  podman_configure        Run Ansible setup in a Podman container."
	@echo "  help                    Display this help message."
