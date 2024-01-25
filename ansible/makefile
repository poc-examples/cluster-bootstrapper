# List of variables to check
REQUIRED_VARS = OPENSHIFT_API_URL \
				OPENSHIFT_TOKEN
				

SHELL := /bin/bash

check-env:
	@errors=0; \
	for var in $(REQUIRED_VARS); do \
		if [ -z "$${!var}" ]; then \
			echo "Error: Environment variable $$var is not set"; \
			errors=1; \
		fi; \
	done; \
	if [ $$errors -ne 0 ]; then \
		exit 1; \
	fi;

default: check-env
	@ansible-playbook bootstrap.yml
