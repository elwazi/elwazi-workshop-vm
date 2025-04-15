variable "ssh_key_public" {
  type = string
  description = "The location of the ssh key you wish to use"
}
variable "floating_ip_pool" {
  type = string
  default = "Ext_Floating_IP"
  description = "The name of the floating_floating_ip_pool"
}
variable "ceph_net_name" {
  type = string
  default="Ceph-net"
  description = "The name of the CEPH network — important for the cephfs shares that are created"
}
variable "ceph_subnet_name" {
  type = string
  default="Ceph-subnet"
  description = "The name of the ceph subnet"
}
variable "server_name" {
  type = string
  default = "elwazi-workshop"
  description = "A prefix that is used when naming the servers/VMs"
}
variable "cidr" {
  type    = string
  default = "192.168.40.0/24"
  description = "The CIDR of the network to be created. Should probably be unique and not overlapping with other networks on the tennant/project"
}
variable "server_count" {
  type = number
  default = 2
  description = "The number of servers to create"
}
variable "users_per_server" {
  type = number
  default = 2
  description = "The number of users to create per server"
}
variable "server_flavor" {
  type = string
  default = "ilifu-A"
  description = "The flavor of the compute servers"
}
variable "login_flavor" {
  type = string
  default = "ilifu-A"
  description = "The flavor of the login machine"
}
variable "login_domain_name" {
  type = string
  description = "The DNS entry for the login node"
}
variable "server_image" {
  type = string
  default = "20250320-noble"
  description = "The image to be used as the starting point for the VMs"
}
variable "admin_users" {
  type = list(map(string))
  default = [
    {
      username = "dane"
      public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSU6y4lUazLnlyf/Ug+xYm2wI+zO3rd8L/7sAvChfaP"
    }
  ]
  description = "A list of users to be configured with elevated privileges"
}

variable "install_biotools" {
  type = bool
  default = false
  description = "Should basic bioinformatics tools be installed"
}

variable "install_cromwell" {
  type = bool
  default = true
  description = "Should cromwell/WDL be installed"
}

variable "install_docker" {
  type = bool
  default = true
  description = "Should docker be installed"
}

variable "install_jupyter" {
  type = bool
  default = true
  description = "Should jupyter be installed"
}

variable "install_nextflow" {
  type = bool
  default = true
  description = "Should nextflow be installed"
}

variable "install_rstudio" {
  type = bool
  default = true
  description = "Should RStudio be installed"
}

variable "install_singularity" {
  type = bool
  default = true
  description = "Should singularity be installed"
}

variable "home_share_size_gb" {
  type = number
  default = 20
  description = "The size of the home share in GB — this is the location where all user and admin home directories are created"
}

variable "scratch_share_size_gb" {
  type = number
  default = 1024
  description = "A scratch storage mount for temporary files"
}

variable "software_share_size_gb" {
  type = number
  default = 40
  description = "The size of the software share"
}

variable "data_share_size_gb" {
  type = number
  default = 100
  description = "The size of the data share — a good place to put data that everyone will use"
}
