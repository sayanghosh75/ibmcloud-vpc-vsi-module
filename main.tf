##############################################################################
# Main routine to create VPC virtual server instance
##############################################################################

# Provider block required with Schematics to set VPC region
provider "ibm" {
  region = var.ibm_region
  #ibmcloud_api_key = var.ibmcloud_api_key         
  generation = local.generation
}

data "ibm_resource_group" "all_rg" {
  name = var.resource_group_name
}

locals {
  generation     = 2
}


# Create virtual server instance 
module "vsi" {
  source                   = "./vsimodule"
  ibm_region               = var.ibm_region
#   bastion_count            = var.bastion_count
  unique_id                = var.vpc_name
  ibm_is_vpc_id            = module.vpc.vpc_id
  ibm_is_resource_group_id = data.ibm_resource_group.all_rg.id
  ...
}
