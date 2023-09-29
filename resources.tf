resource "local_file" "ansible_inventory" {
  content = templatefile("templates/inventory.yaml.tpl",
    {
      workshop_servers = [for node in openstack_compute_instance_v2.base.*: node ]
      floating_ips = [for address in openstack_networking_floatingip_v2.base.* : address]
      passwords = [for password in random_password.password.*: password.result]
      ssh_public_key = var.ssh_key_public
      admin_users = var.admin_users
    }
  )
  filename = "inventory.yaml"
  file_permission = "0660"
}
