resource "openstack_sharedfilesystem_share_v2" "home_share" {
  name             = "${var.server_name}_home"
  description      = "shared fs for home directories"
  share_proto      = "CEPHFS"
  share_type       = "cephfs"
  size             = "${var.home_share_size_gb}"
  availability_zone = "nova"
}

resource "openstack_sharedfilesystem_share_access_v2" "home_share_access_rw" {
  share_id     = openstack_sharedfilesystem_share_v2.home_share.id
  access_type  = "cephx"
  access_to    = "workshop_users_rw"
  access_level = "rw"
}

resource "openstack_sharedfilesystem_share_v2" "software_share" {
  name             = "${var.server_name}_software"
  description      = "shared fs for software"
  share_proto      = "CEPHFS"
  share_type       = "cephfs"
  size             = "${var.software_share_size_gb}"
  availability_zone = "nova"
}

resource "openstack_sharedfilesystem_share_access_v2" "software_share_access_rw" {
  share_id     = openstack_sharedfilesystem_share_v2.software_share.id
  access_type  = "cephx"
  access_to    = "workshop_users_rw"
  access_level = "rw"
}

resource "openstack_sharedfilesystem_share_v2" "scratch_share" {
  name             = "${var.server_name}_scratch"
  description      = "shared fs for scratch space"
  share_proto      = "CEPHFS"
  share_type       = "cephfs"
  size             = "${var.scratch_share_size_gb}"
  availability_zone = "nova"
}

resource "openstack_sharedfilesystem_share_access_v2" "scratch_share_access_rw" {
  share_id     = openstack_sharedfilesystem_share_v2.scratch_share.id
  access_type  = "cephx"
  access_to    = "workshop_users_rw"
  access_level = "rw"
}

resource "openstack_sharedfilesystem_share_v2" "data_share" {
  name             = "${var.server_name}_data"
  description      = "shared fs for data"
  share_proto      = "CEPHFS"
  share_type       = "cephfs"
  size             = "${var.data_share_size_gb}"
  availability_zone = "nova"
}

resource "openstack_sharedfilesystem_share_access_v2" "data_share_access_rw" {
  share_id     = openstack_sharedfilesystem_share_v2.data_share.id
  access_type  = "cephx"
  access_to    = "workshop_users_rw"
  access_level = "rw"
}
