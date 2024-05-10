SHELL := /bin/bash

REQUIRED_ENV_VARS := AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY

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

build: check-shell
	@terraform -chdir=terraform init
	@terraform -chdir=terraform plan -out=terraform.tfplan
	@terraform -chdir=terraform apply terraform.tfplan

plan: check-shell
	@terraform -chdir=terraform init
	@terraform -chdir=terraform plan

configure:
	@ansible-playbook ansible/bootstrap.yaml
	@echo configure

deploy: build configure
	@echo "Set this to provide cluster information"

destroy:
	@echo "Destroy"
