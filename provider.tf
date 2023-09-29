variable "ssh_key_public" {}
variable "floating_ip_pool" {}
variable "server_name" {}
variable "server_count" {}
variable "users_per_server" {}
variable "server_flavor" {}
variable "server_image" {}

terraform {
  required_version = ">= 1.1.9"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.47.0"
    }
  }
}

provider "openstack" {
}
