import os
import yaml

REQUIRED_ENV = [
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY"
]

# Load the vars.yaml file
vars_file = './vars.yaml'

# Load and decode the YAML file
with open(vars_file, 'r') as file:
    config = yaml.safe_load(file)

# Function to check if the script is running in a container
def check_os():
    container_env = os.path.exists('/.dockerenv') or os.path.exists('/run/.containerenv')
    with open('/proc/1/environ', 'r') as f:
        container_flag = 'container=' in f.read()

    if container_env or container_flag:
        print("Run Mode: Container")
        print(f"Container Hostname: {os.uname().nodename}\n")
        with open('/etc/os-release', 'r') as os_info:
            print(os_info.read())
    else:
        print("Run Mode: Local")

# Function to check required environment variables
def check_shell():

    checks_failed = False
    for var in REQUIRED_ENV:
        if os.getenv(var) is None:
            checks_failed = True
            print(f"Error: {var} is not set")
        else:
            print(f"{var} is set")
    if checks_failed:
        exit(1)
    
    print("All required environment variables are set.")

# Example Usage
if __name__ == "__main__":
    # Assuming openshift.terraform is stored in the vars.yaml file
    terraform_enabled = config.get('openshift', {}).get('terraform', True)

    # Check OS only if terraform is not explicitly set to false
    if terraform_enabled:
        check_shell()
    else:
        print("Skipping Checks: terraform is set to false")

    # Check required environment variables
    check_os()
