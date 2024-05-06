SHELL := /bin/bash

init: 
	@ansible-playbook ansible/bootstrap.yaml
