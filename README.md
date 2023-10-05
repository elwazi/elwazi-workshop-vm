# Setting up the server (with terraform and ansible)

## Requirements

Terraform, ansible and an account on an OpenStack cloud.

## Clone the repository

```bash
$ git clone https://github.com/elwazi/elwazi-workshop-vm.git
$ cd elwazi-workshop-vm
````

## Create a virtual environment with ansible installed
If you have pipenv installed you can simply use the supplied Pipfiles:
```bash
$ pipenv sync
```

Otherwise you can create a virtual environment and install ansible:
```bash
$ virtualenv .venv
$ . ./.venv/bin/activate
$ pip install ansible
```

Optionally install the openstack client as well:
```bash
$ pip install python-openstackclient
```

## Download your openstack rc file and source it
Login to your openstack account and download your openstack rc file, say `MyProject-openrc.rc`.
Source your openstack rc file:
```bash
$ . MyProject-openrc.rc
````

## Initialise terraform

```bash
$ terraform init
```

## Setup the variables file

The file has a list of variables that are used to setup the nodes together with a description
and default values.

Create a file called `terraform.tfvars` for example:

```hcl terraform.tfvars
ssh_key_public = "~/.ssh/id_rsa.pub"

server_name = "elwazi-cww"

server_count = 16
users_per_server = 2
server_flavor = "ilifu-C-30"

server_image = "20230914-jammy"

admin_users = [
  {
    username = "admin1"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQ…"
  },
  {
    username = "admin2"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQ…"
  },
  
]
```
If you installed the openstack client you can find available images using:
```bash
$ openstack image list
```
Note that this has been developed and tested using an ubuntu jammy image…

## Run `terraform` to deploy the nodes
```bash
$ terraform apply
```
This will create an inventory file `inventory.yaml` that will be used by ansible to setup the nodes.

## Run `ansible-playbook` to setup the nodes
```bash
$ ansible-playbook -i inventory.yaml setup.yaml
```
You can check the inventory file to find the IP addresses of the nodes.
Terraform will also have created a tab-separated file called `users.tsv` which has login details
for each of the users.