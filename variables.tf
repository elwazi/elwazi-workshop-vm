variable "ssh_key_public" {
  type = string
}
variable "floating_ip_pool" {
  type = string
  default = "Ext_Floating_IP"
}
variable "server_name" {
  type = string
  default = "elwazi-workshop"
}
variable "server_count" {
  type = number
  default = 2
}
variable "users_per_server" {
  type = number
  default = 2
}
variable "server_flavor" {
  type = string
  default = "ilifu-A"
}
variable "server_image" {
  type = string
  default = "20230914-jammy"
}
variable "admin_users" {
  type = list(map(string))
  default = [
    {
      username = "dane"
      public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSU6y4lUazLnlyf/Ug+xYm2wI+zO3rd8L/7sAvChfaP"
    }
  ]
}

variable "install_biotools" {
  type = bool
  default = false
}

variable "install_cromwell" {
  type = bool
  default = true
}

variable "install_docker" {
  type = bool
  default = true
}

variable "install_jupyter" {
  type = bool
  default = true
}

variable "install_nextflow" {
  type = bool
  default = true
}

variable "install_singularity" {
  type = bool
  default = true
}

variable "home_share_size_gb" {
  type = number
  default = 20
}

variable "scratch_share_size_gb" {
  type = number
  default = 1024
}

variable "software_share_size_gb" {
  type = number
  default = 40
}

variable "data_share_size_gb" {
  type = number
  default = 100
}
