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
$ pipenv shell
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
$ . ./MyProject-openrc.rc
````
Note you will prompted for your password so have that ready.

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
If you look at the `variables.tf` file you can see the available variables, their default values and a description of what they're for. At a minimum you will need to configure the variables that have no default values.

If you installed the openstack client you can find available images (for the `server_image` variable) using:
```bash
$ openstack image list
```
Note that you will need `server_count` available floating IP addresses, so consider this when
you're deciding on the number of nodes to create. Also note that this has been developed and tested
using an ubuntu jammy image…

## Run `terraform` to deploy the nodes
```bash
$ terraform apply
```
This will create an inventory file `inventory.yaml` that will be used by ansible to setup the nodes.
There will also be a tab-separated file called `users.tsv` which has login details for each of the users.

Check the inventory for the IP address of the `login_node`. You will need to set the DNS to point at this IP address.

## Run `ansible-playbook` to setup the nodes
```bash
$ ansible-playbook -i inventory.yaml site.yaml  # --extra-vars "reboot_after_update=yes"
```
You can check the inventory file to find the IP addresses of the nodes.
