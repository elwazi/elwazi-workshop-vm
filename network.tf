data "openstack_networking_network_v2" "ceph_net" {
  name = var.ceph_net_name
}

data "openstack_networking_subnet_v2" "ceph_subnet" {
  name = var.ceph_subnet_name
}

resource "openstack_networking_network_v2" "workshop_network" {
    name = "${var.server_name}-net"
    admin_state_up = "true"
}

data "openstack_networking_network_v2" "public" {
  name = var.floating_ip_pool
}


resource "openstack_networking_subnet_v2" "workshop_subnet" {
    name = "${var.server_name}-subnet"
    network_id = openstack_networking_network_v2.workshop_network.id
    cidr = "192.168.40.0/24"
    ip_version = 4
    enable_dhcp = "true"
    dns_nameservers = ["8.8.8.8"]
}

resource "openstack_networking_router_v2" "workshop_router" {
  name                = "${var.server_name}-router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.public.id
}

resource "openstack_networking_router_interface_v2" "workshop_router_interface" {
  router_id = openstack_networking_router_v2.workshop_router.id
  subnet_id = openstack_networking_subnet_v2.workshop_subnet.id
}

resource "openstack_networking_secgroup_v2" "workshop_security" {
  name        = "${var.server_name}-security"
  description = "Workshop security group"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.workshop_security.id
}

resource "openstack_networking_secgroup_rule_v2" "https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.workshop_security.id
}


resource "openstack_compute_keypair_v2" "terraform-key" {
  name   = "${var.server_name}-key"
  public_key = "${file(var.ssh_key_public)}"
}

resource "openstack_networking_floatingip_v2" "base" {
  description  = format("fip-%s-%02s", var.server_name,count.index + 1)
  pool = var.floating_ip_pool
  count = var.server_count
}

resource "openstack_compute_floatingip_associate_v2" "base" {
  count = var.server_count
  floating_ip = openstack_networking_floatingip_v2.base[count.index].address
  instance_id = openstack_compute_instance_v2.base[count.index].id
}
