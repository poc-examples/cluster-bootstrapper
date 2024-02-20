SHELL := /bin/bash

default: 
	@ansible-playbook src/bootstrap.yaml
