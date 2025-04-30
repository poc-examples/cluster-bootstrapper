SHELL := /bin/bash

REQUIRED_ENV_VARS := AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY

preflight_checks:
	@python3 -m pip install --no-cache-dir -r scripts/requirements.txt
	@python3 ./scripts/preflight-checks.py 

render_templates:
	@python3 scripts/render.py

terraform_apply: 
	@terraform -chdir=terraform init
	@terraform -chdir=terraform plan -out=terraform.tfplan
	@terraform -chdir=terraform apply terraform.tfplan

terraform_plan: 
	@terraform -chdir=terraform init
	@terraform -chdir=terraform plan

ansible_setup: 
	@ansible-galaxy install -r ansible/requirements.yaml --force
	@ansible-playbook ansible/bootstrap.yaml -i ansible/inventory.yaml

terraform_destroy: 
	@terraform -chdir=terraform destroy $(AUTO_APPROVE)

build:
	@podman run --rm -it \
		-v $(shell pwd)/:/usr/src/app:z \
		-w /usr/src/app \
		-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
		-e CLUSTER_USERNAME=${CLUSTER_USERNAME} \
		-e CLUSTER_PASSWORD=$(CLUSTER_PASSWORD) \
		-e ROSA_TOKEN=${ROSA_TOKEN} \
		-e VAULT_TOKEN=${VAULT_TOKEN} \
		docker.io/cengleby86/bootstrapper:latest \
		bash -c "\
			j2 --format=env config.yaml > vars.yaml \
			&& echo -e '\\nJinja2 template rendered\\n' \
			&& make preflight_checks \
			&& make render_templates \
			&& make terraform_apply \
		"

plan:
	@podman run --rm -it \
		-v $(shell pwd)/:/usr/src/app:z \
		-w /usr/src/app \
		-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
		-e CLUSTER_USERNAME=${CLUSTER_USERNAME} \
		-e CLUSTER_PASSWORD=$(CLUSTER_PASSWORD) \
		-e ROSA_TOKEN=${ROSA_TOKEN} \
		-e VAULT_TOKEN=${VAULT_TOKEN} \
		docker.io/cengleby86/bootstrapper:latest \
		bash -c "\
			j2 --format=env config.yaml > vars.yaml \
			&& echo -e '\\nJinja2 template rendered\\n' \
			&& make preflight_checks \
			&& make render_templates \
			&& make terraform_plan \
		"

configure:
	@podman run --rm -it \
		-v $(shell pwd)/:/usr/src/app:z \
		-w /usr/src/app \
		-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
		-e CLUSTER_USERNAME=${CLUSTER_USERNAME} \
		-e CLUSTER_PASSWORD=$(CLUSTER_PASSWORD) \
		-e ROSA_TOKEN=${ROSA_TOKEN} \
		-e VAULT_TOKEN=${VAULT_TOKEN} \
		docker.io/cengleby86/bootstrapper:latest \
		bash -c "\
			j2 --format=env config.yaml > vars.yaml \
			&& echo -e '\\nJinja2 template rendered\\n' \
			&& make preflight_checks \
			&& make ansible_setup \
		"

cleanup:
	@podman run --rm -it \
		-v $(shell pwd)/:/usr/src/app:z \
		-w /usr/src/app \
		-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
		-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
		-e CLUSTER_USERNAME=${CLUSTER_USERNAME} \
		-e CLUSTER_PASSWORD=$(CLUSTER_PASSWORD) \
		-e ROSA_TOKEN=${ROSA_TOKEN} \
		-e VAULT_TOKEN=${VAULT_TOKEN} \
		docker.io/cengleby86/bootstrapper:latest \
		bash -c "\
			j2 --format=env config.yaml > vars.yaml \
			&& echo -e '\\nJinja2 template rendered\\n' \
			&& make preflight_checks \
			&& make render_templates \
			&& make terraform_destroy AUTO_APPROVE="-auto-approve" \
		"
help:
	@echo "Usage: make [target]"
	@echo
	@echo "Available targets:"
	@echo "  build                  Builds an OpenShift Cluster."
	@echo "  configure              Configures the Cluster and Deploys a workshop."
	@echo "  cleanup        		Destroys an OpenShift Cluster."
