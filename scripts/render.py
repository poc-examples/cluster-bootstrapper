import os
from jinja2 import Environment, FileSystemLoader
import yaml

vars_file = './vars.yaml'
terraform_dir = './terraform'
output_inventory_file = './ansible/inventory.yaml'

def render_template(template_name, output_name, variables):
    env = Environment(
        loader=FileSystemLoader(searchpath=terraform_dir)
    )

    template = env.get_template(template_name)
    with open(output_name, 'w') as output_file:
        output_file.write(template.render(variables))

inventory = {
    "localmachines": {
        "hosts": {}
    }
}

with open(vars_file, 'r') as file:
    config = yaml.safe_load(file)

    for cluster in config["openshift"]["clusters"]:

        target_cloud = "local"
        if "type" in cluster.keys():

            if "hcp" in cluster["type"]:
                target_cloud = "aws"

            if "rosa" in cluster["type"]:
                target_cloud = "aws"

            if "aro" in cluster["type"]:
                target_cloud = "azure"

        template_variables = {
            'cloud': target_cloud,
            'type': cluster['type'] if 'type' in cluster else 'local',
            'name': cluster['name']
        }

        # Process each .j2 file in the specified use-cases directory
        for filename in os.listdir(terraform_dir):
            if filename.endswith('.j2'):
                template_file = filename
                output_file = f"{target_cloud}-{template_variables['name']}.tf"
                render_template(
                    template_file, 
                    os.path.join(terraform_dir, output_file), 
                    template_variables
                )
