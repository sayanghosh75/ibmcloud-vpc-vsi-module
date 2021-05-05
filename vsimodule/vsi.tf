##############################################################################
# This file creates a virtual server instance
##############################################################################


resource "ibm_is_instance" "vsi" {
  count   = var.vsi_count
  name    = "${var.unique_id}-vsi-${count.index + 1}"
  image   = data.ibm_is_image.os.id
  profile = var.vsi_profile

  primary_network_interface {
    subnet          = ibm_is_subnet.vsi_subnet[count.index].id
    security_groups = [ibm_is_security_group.vsi.id]
  }

  timeouts {
    create = "10m"
    delete = "10m"
  }

  vpc            = var.ibm_is_vpc_id
  zone           = "${var.ibm_region}-${count.index % 3 + 1}"
  resource_group = var.ibm_is_resource_group_id
  keys           = [var.ssh_key_id]
  user_data      = file("${path.module}/vsi_config.yml")
  tags           = ["schematics:vsi"]
}

resource "ibm_is_floating_ip" "vsi" {
  count  = var.vsi_count
  name   = "${var.unique_id}-float-vsi-ip-${count.index + 1}"
  target = ibm_is_instance.vsi[count.index].primary_network_interface[0].id
}
