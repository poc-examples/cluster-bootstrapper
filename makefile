SHELL := /bin/bash

init: 
	@ansible-playbook src/bootstrap.yaml
