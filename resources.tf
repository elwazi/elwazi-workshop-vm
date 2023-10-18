resource "local_file" "ansible_inventory" {
  content = templatefile("templates/inventory.yaml.tpl",
    {
      workshop_servers = [for node in openstack_compute_instance_v2.base.*: node ]
      floating_ips = [for address in openstack_networking_floatingip_v2.base.* : address]
      passwords = [for password in random_password.password.*: password.result]
      ssh_public_key = var.ssh_key_public
      admin_users = var.admin_users
      users_per_server = var.users_per_server
      install = {
        biotools = var.install_biotools,
        cromwell = var.install_cromwell,
        docker = var.install_docker,
        jupyter = var.install_jupyter,
        nextflow = var.install_nextflow,
        singularity = var.install_singularity,
      }
    }
  )
  filename = "inventory.yaml"
  file_permission = "0660"
}

resource "local_file" "user_list" {
  content = templatefile("templates/users.tsv.tpl",
    {
      workshop_servers = [for node in openstack_compute_instance_v2.base.*: node ]
      floating_ips = [for address in openstack_networking_floatingip_v2.base.* : address]
      passwords = [for password in random_password.password.*: password.result]
      admin_users = var.admin_users
      users_per_server = var.users_per_server
    }
  )
  filename = "users.tsv"
  file_permission = "0660"
}
