resource "local_file" "ansible_inventory" {
  content = templatefile("templates/inventory.yaml.tpl",
    {
      workshop_servers = [for node in openstack_compute_instance_v2.base.*: node ]
      floating_ip = openstack_networking_floatingip_v2.login.address
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
      # floating_ips = [for address in openstack_networking_floatingip_v2.base.* : address]
      ips = [for address in openstack_compute_instance_v2.base.* : address.access_ip_v4]
      passwords = [for password in random_password.password.*: password.result]
      admin_passwords = [for password in random_password.admin_password.*: password.result]
      admin_users = var.admin_users
      users_per_server = var.users_per_server
    }
  )
  filename = "users.tsv"
  file_permission = "0660"
}

resource "local_file" "group_vars_ceph" {
  content = templatefile("templates/group_vars_ceph.tpl",
    {
      ceph_mounts = {
        home: {
          name: "home"
          mount_point: "/users"
          export_locations: openstack_sharedfilesystem_share_v2.home_share.export_locations,
          access: openstack_sharedfilesystem_share_access_v2.home_share_access_rw.access_key,
          access_to: openstack_sharedfilesystem_share_access_v2.home_share_access_rw.access_to
        }
        software: {
          name: "software"
          mount_point: "/software"
          export_locations: openstack_sharedfilesystem_share_v2.software_share.export_locations,
          access: openstack_sharedfilesystem_share_access_v2.software_share_access_rw.access_key,
          access_to: openstack_sharedfilesystem_share_access_v2.software_share_access_rw.access_to
        }
        scratch: {
          name: "scratch"
          mount_point: "/scratch"
          export_locations: openstack_sharedfilesystem_share_v2.scratch_share.export_locations,
          access: openstack_sharedfilesystem_share_access_v2.scratch_share_access_rw.access_key,
          access_to: openstack_sharedfilesystem_share_access_v2.scratch_share_access_rw.access_to
        }
        data: {
          name: "data"
          mount_point: "/data"
          export_locations: openstack_sharedfilesystem_share_v2.data_share.export_locations,
          access: openstack_sharedfilesystem_share_access_v2.data_share_access_rw.access_key,
          access_to: openstack_sharedfilesystem_share_access_v2.data_share_access_rw.access_to
        }
      }
    }
  )
  filename = "group_vars/all/ceph.yml"
}

resource "local_file" "group_vars_users" {
  content = templatefile("templates/group_vars_users.yaml.tpl",
    {
      passwords = [for password in random_password.password.*: password.result]
      admin_users = var.admin_users

    }
  )
  filename = "group_vars/all/users.yml"
}
