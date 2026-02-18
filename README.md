# Setting up the server (with terraform and ansible)

## Requirements

- [Terraform](https://www.terraform.io/)
- [Ansible](https://www.ansible.com/)
- [uv](https://docs.astral.sh/uv/) (Python package manager)
- An account on an OpenStack cloud

## Clone the repository

```bash
git clone https://github.com/ilifu/jupyter-workshop-vms.git
cd jupyter-workshop-vms
```

## Create a virtual environment and install dependencies

This project uses `uv` to manage the Python virtual environment and dependencies (ansible, passlib, and the openstack client). The dependencies are defined in `pyproject.toml`.

```bash
uv sync
```

This will create a `.venv` virtual environment and install all required packages. To run commands within the environment, prefix them with `uv run` or activate the environment:

```bash
source .venv/bin/activate
```

## Download your OpenStack RC file and source it

Login to your OpenStack account and download your OpenStack RC file, say `MyProject-openrc.sh`.
Source your OpenStack RC file:
```bash
source ./MyProject-openrc.sh
```
Note: you will be prompted for your password so have that ready.

## Initialise terraform

```bash
terraform init
```

## Setup the variables file

The file has a list of variables that are used to setup the nodes together with a description
and default values.

Create a file called `terraform.tfvars` for example:

```hcl
ssh_key_public = "~/.ssh/id_rsa.pub"
login_domain_name = "mamana-workshop.ilifu.ac.za"

cidr = "192.168.70.0/24"

server_name = "mamana-workshop"

server_count = 1
users_per_server = 30
server_flavor = "ilifu-G-240G"

server_image = "20250320-noble"

admin_users = [
  {
    username = "dane"
    public_key = "ssh-ed25519 AAAAwaddawaddawadda"
  }
]

install_biotools = true
install_cromwell = false
install_docker = false
install_jupyter = true
install_nextflow = false
install_rstudio = false
install_singularity = false

home_share_size_gb = 20
scratch_share_size_gb = 80
software_share_size_gb = 20
data_share_size_gb = 40
```

Refer to `variables.tf` for all available variables, their default values and descriptions.
At a minimum you will need to configure the variables that have no default values.

If you installed the openstack client you can find available images (for the `server_image` variable) using:
```bash
uv run openstack image list
```

Note that you will need `server_count` available floating IP addresses, so consider this when
deciding on the number of nodes to create.

## Run `terraform` to deploy the nodes

```bash
terraform apply
```

This will create:
- An inventory file `inventory.yaml` used by ansible to setup the nodes.
- A tab-separated file `users.tsv` with login details for each user.

Check the inventory for the IP address of the `login_node`. You will need to set the DNS to point at this IP address.

## Run `ansible-playbook` to setup the nodes

```bash
uv run ansible-playbook -i inventory.yaml site.yaml  # --extra-vars "reboot_after_update=yes"
```

You can check the inventory file to find the IP addresses of the nodes.
