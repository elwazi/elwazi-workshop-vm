resource "openstack_compute_instance_v2" "base" {
    count = var.server_count
    name            = format("%s-%02s", var.server_name,count.index + 1)
    image_name      = var.server_image
    flavor_name     = var.server_flavor
    key_pair        = openstack_compute_keypair_v2.terraform-key.name
    security_groups = ["default"]

    network {
      name = openstack_networking_network_v2.workshop_network.name
    }
}

resource "random_password" "password" {
  count            = var.users_per_server * var.server_count
  length           = 16
  special          = true
  override_special = "_"
}
