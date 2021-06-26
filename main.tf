##############################################################################
# Main routine to create VPC virtual server instance
##############################################################################

# Read attributes of existing VPC resources 

data "ibm_resource_group" "ds_rg" {
  name = var.resource_group_name
}

data "ibm_is_vpc" "ds_vpc" {
  name = var.vpc_name
}

data "ibm_is_subnet" "ds_subnet" {
  name = var.subnet_name
}

data "ibm_is_security_group" "ds_sg" {
  name = var.security_group_name
}

data "ibm_is_ssh_key" "ds_key" {
  name = var.ssh_key_name
}

data "ibm_is_image" "ds_os" {
  name = var.vsi_image
}




# # Create virtual server instance

resource "ibm_is_instance" "vsi" {
  count          = var.vsi_count
  name           = "${var.vsi_prefix}-vsi-${count.index + 1}"
  image          = data.ibm_is_image.ds_os.id
  profile        = var.vsi_profile

  primary_network_interface {
    subnet          = data.ibm_is_subnet.ds_subnet.id
    security_groups = [data.ibm_is_security_group.ds_sg.id]
  }

  vpc            = data.ibm_is_subnet.ds_subnet.vpc
  zone           = data.ibm_is_subnet.ds_subnet.zone
  resource_group = data.ibm_resource_group.ds_rg.id
  keys           = [data.ibm_is_ssh_key.ds_key.id]
  # user_data      = file("${path.module}/vsi_config.yml")
  user_data      = data.template_cloudinit_config.vsi_userdata.rendered  //  Cloudinit data

  timeouts {
    create = "10m"
    delete = "10m"
  }

  tags           = ["schematics:vsi"]
}


# Provision floating IP if requested 

resource "ibm_is_floating_ip" "vsi" {
  count  = var.floating_ip ? 1: 0             # Count is 0 if variable set to false, 1 if set to true
  name   = "${ibm_is_instance.vsi.name}-fip-${count.index + 1}"
  target = ibm_is_instance.vsi[count.index].primary_network_interface[0].id
}







# # Create virtual server instance - calls module
# module "vsi" {
#   source                   = "./vsimodule"
#   ibm_region               = var.ibm_region
# #   bastion_count            = var.bastion_count
#   unique_id                = var.vsi_prefix
#   ibm_is_vpc_id            = var.vpc_id
#   ibm_is_resource_group_id = data.ibm_resource_group.all_rg.id
#   ...
# }