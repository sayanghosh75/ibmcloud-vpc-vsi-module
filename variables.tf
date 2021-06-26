##############################################################################
# Account Variables
##############################################################################

# Target region
variable "ibm_region" {
  description = "IBM Cloud region where the VPC is deployed"
  default     = "au-syd"
}

# variable "ibmcloud_api_key" {
#   description = "IBM Cloud API key when run standalone"
# }

# Resource group name - SHOULD BE ABLE TO READ THIS FROM VPC
variable "resource_group_name" {
  description = "Name of IBM Cloud resource group to be used for new VPC resources"
  default     = "VPC-admin"
}


##############################################################################
# Network variables
##############################################################################

# VPC name in which we will provision VSIs - must aleady exist 
variable "vpc_name" {
  description = "Name of existing VPC"
}

# Subnet to which we will attach VSIs - must aleady exist 
variable "subnet_name" {
  description = "Name of existing subnet within the VPC"
}

# Security group to which we will attach network interfaces - must aleady exist 
variable "security_group_name" {
  description = "Name of existing security group within the VPC"
}



##############################################################################
# Virtual server variables
##############################################################################

# Unique prefix for VSI names 
variable "vsi_prexfix" {
  description = "Unique prefix for VSI names"
}

variable "vsi_count" {
  description = "Number of VSIs to be provisioned"
  default     = 1
}

variable "vsi_image" {
  description = "Image name from VPC image catalog"
  default     = "ibm-ubuntu-20-04-minimal-amd64-2"
}

variable "vsi_profile" {
  description = "Profile name from VPC image catalog"
  default     = "cx2-2x4"
}

variable "ssh_key_name" {
  description = "Name of SSH key to loaded"
  default     = "shallcrm-ibmcloud-ssh-key"
}

variable "floating_ip" {
  description = "Add floating IP?"
  default     = false
}
