import os
from jinja2 import Environment, FileSystemLoader
import yaml

vars_file = './vars.yaml'
terraform_dir = './terraform'

# Load and decode the YAML file
with open(vars_file, 'r') as file:
    config = yaml.safe_load(file)

cloud = ""
if "aws" in config['openshift'].keys():
    cloud = "aws"

if "azure" in config['openshift'].keys():
    cloud = "azure"

# Gather environment variables
variables = {
    'cloud': cloud,
    'type': config['openshift'][cloud]['type']
}

def render_template(template_name, output_name, variables):
    env = Environment(
        loader=FileSystemLoader(searchpath=terraform_dir)
    )

    template = env.get_template(template_name)
    with open(output_name, 'w') as output_file:
        output_file.write(template.render(variables))


# Directory for use cases based on the cluster type
terraform_dir = './terraform'

# Process each .j2 file in the specified use-cases directory
for filename in os.listdir(terraform_dir):
    if filename.endswith('.j2'):
        template_file = filename
        output_file = filename.rstrip('.j2')
        render_template(
            template_file, 
            os.path.join(terraform_dir, output_file), 
            variables
        )
