##############################################################################
# IBM Cloud provider block 
##############################################################################

# Provider block required with Schematics to set VPC region
provider "ibm" {
  region = var.ibm_region
  #ibmcloud_api_key = var.ibmcloud_api_key         
}
