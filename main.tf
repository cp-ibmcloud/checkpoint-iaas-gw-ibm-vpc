##############################################################################
# IBM Cloud Provider 1.35.0
##############################################################################

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  generation       = 2
  region           = var.VPC_Region
  ibmcloud_timeout = 300
  resource_group   = var.Resource_Group
}

##############################################################################
# Variable block - See each variable description
##############################################################################

variable "VPC_Region" {
  default     = ""
  description = "The region where the VPC, networks, and Check Point VSI will be provisioned."
}

variable "Resource_Group" {
  default     = ""
  description = "The resource group that will be used when provisioning the Check Point VSI. If left unspecififed, the account's default resource group will be used."
}

variable "VPC_Name" {
  default     = ""
  description = "The VPC where the Check Point VSI will be provisioned."
}

variable "Management_Subnet_ID" {
  default     = ""
  description = "The ID of the Check Point management subnet."
}

variable "External_Subnet_ID" {
  default     = ""
  description = "The ID of the subnet that exists in front of the Check Point Security Gateway that will be provisioned (the 'external' network)."
}

variable "Internal_Subnet_ID" {
  default     = ""
  description = "The ID of the subnet that exists behind  the Check Point Security Gateway that will be provisioned (the 'internal' network)."
}

variable "SSH_Key" {
  default     = ""
  description = "The pubic SSH Key that will be used when provisioning the Check Point VSI."
}

variable "VNF_CP-GW_Instance" {
  default     = "checkpoint-gateway"
  description = "The name of the Check Point Security Gatewat that will be provisioned."
}

variable "VNF_Security_Group" {
  default     = ""
  description = "The name of the security group assigned to the Check Point VSI."
}

variable "VNF_Profile" {
  default     = "cx2-8x16"
  description = "The VNF profile that defines the CPU and memory resources. This will be used when provisioning the Check Point VSI."
}

variable "CP_Version" {
  default     = "R8120"
  description = "The version of Check Point to deploy. R8120, R8110"
}

variable "CP_Type" {
  default     = "Gateway"
  description = "(HIDDEN) Gateway or Management"
}

variable "vnf_license" {
  default     = ""
  description = "(HIDDEN) Optional. The BYOL license key that you want your cp virtual server in a VPC to be used by registration flow during cloud-init."
}

variable "ibmcloud_endpoint" {
  default     = "cloud.ibm.com"
  description = "(HIDDEN) The IBM Cloud environmental variable 'cloud.ibm.com' or 'test.cloud.ibm.com'"
}

variable "delete_custom_image_confirmation" {
  default     = ""
  description = "(HIDDEN) This variable is to get the confirmation from customers that they will delete the custom image manually, post successful installation of VNF instances. Customer should enter 'Yes' to proceed further with the installation."
}

variable "ibmcloud_api_key" {
  default     = ""
  description = "(HIDDEN) holds the user api key"
}

variable "TF_VERSION" {
 default = "1.0"
 description = "terraform engine version to be used in schematics"
}

# Variables for VNIs
variable "vni_mgmt_interface_name" {
  default     = "management-interface"
  description = "Name of interface VNI management."
}

variable "vni_ext_interface_name" {
  default     = "external-interface"
  description = "Name of interface VNI external."
}

variable "vni_int_interface_name" {
  default     = "internal-interface"
  description = "Name of interface VNI internal."
}

##############################################################################
# Data block 
##############################################################################

data "ibm_is_subnet" "cp_subnet0" {
  identifier = var.Management_Subnet_ID
}

data "ibm_is_subnet" "cp_subnet1" {
  identifier = var.External_Subnet_ID
}

data "ibm_is_subnet" "cp_subnet2" {
  identifier = var.Internal_Subnet_ID
}

data "ibm_is_ssh_key" "cp_ssh_pub_key" {
  name = var.SSH_Key
}

data "ibm_is_instance_profile" "vnf_profile" {
  name = var.VNF_Profile
}

data "ibm_is_region" "region" {
  name = var.VPC_Region
}

data "ibm_is_vpc" "cp_vpc" {
  name = var.VPC_Name
}

data "ibm_resource_group" "rg" {
  name = var.Resource_Group
}

##############################################################################
# Create Security Group
##############################################################################

resource "ibm_is_security_group" "ckp_security_group" {
  name           = var.VNF_Security_Group
  vpc            = data.ibm_is_vpc.cp_vpc.id
  resource_group = data.ibm_resource_group.rg.id
}

#Egress All Ports
resource "ibm_is_security_group_rule" "allow_egress_all" {
  depends_on = [ibm_is_security_group.ckp_security_group]
  group      = ibm_is_security_group.ckp_security_group.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
}

#Ingress All Ports
resource "ibm_is_security_group_rule" "allow_ingress_all" {
  depends_on = [ibm_is_security_group.ckp_security_group]
  group      = ibm_is_security_group.ckp_security_group.id
  direction  = "inbound"
  remote     = "0.0.0.0/0"
}

##############################################################################
# Create Virtual Network Interfaces (VNIs)
##############################################################################

# VNI for Interface Management
resource "ibm_is_virtual_network_interface" "rip_vnic_vsi_gw" {
  #allow_ip_spoofing         = false
  auto_delete               = false
  enable_infrastructure_nat = true
  name                      = var.vni_mgmt_interface_name
  subnet                    = data.ibm_is_subnet.cp_subnet0.id
  security_groups           = [ibm_is_security_group.ckp_security_group.id]
  resource_group            = data.ibm_resource_group.rg.id
}

# VNI for Interface External
resource "ibm_is_virtual_network_interface" "rip_vnic_ext_vsi_gw" {
  #allow_ip_spoofing         = true
  auto_delete               = false
  enable_infrastructure_nat = true
  name                      = var.vni_ext_interface_name
  subnet                    = data.ibm_is_subnet.cp_subnet1.id
  security_groups           = [ibm_is_security_group.ckp_security_group.id]
  resource_group            = data.ibm_resource_group.rg.id
}

# VNI for Interface Internal
resource "ibm_is_virtual_network_interface" "rip_vnic_int_vsi_gw" {
  #allow_ip_spoofing         = true
  auto_delete               = false
  enable_infrastructure_nat = true
  name                      = var.vni_int_interface_name
  subnet                    = data.ibm_is_subnet.cp_subnet2.id
  security_groups           = [ibm_is_security_group.ckp_security_group.id]
  resource_group            = data.ibm_resource_group.rg.id
}



##############################################################################
# Create Check Point Gateway
##############################################################################

locals {
  image_name = "${var.CP_Version}-${var.CP_Type}"
  image_id = lookup(local.image_map[local.image_name], var.VPC_Region)
}

resource "ibm_is_instance" "cp_gw_vsi" {
  depends_on     = [ibm_is_security_group_rule.allow_ingress_all]
  name           = var.VNF_CP-GW_Instance
  image          = local.image_id
  profile        = data.ibm_is_instance_profile.vnf_profile.name
  resource_group = data.ibm_resource_group.rg.id

  vpc  = data.ibm_is_vpc.cp_vpc.id
  zone = data.ibm_is_subnet.cp_subnet0.zone
  keys = [data.ibm_is_ssh_key.cp_ssh_pub_key.id]
 
 # Attach VNI's to VSI   
  primary_network_attachment {
    name = "management"
      virtual_network_interface {
        id = ibm_is_virtual_network_interface.rip_vnic_vsi_gw.id
        #id = data.ibm_is_virtual_network_interfaces.vni_list.virtual_network_interfaces.id[1]
      }
  }

  #Custom UserData
  user_data = file("user_data")

  timeouts {
    create = "15m"
    delete = "15m"
  }

   provisioner "local-exec" {
    command = "sleep 30"
  }
}
  
# moved below to try and attach interfaces after instance is up

  resource "ibm_is_instance_network_attachment" "attach_vnic_ext_gw" {
  instance = ibm_is_instance.cp_gw_vsi.id
  virtual_network_interface {
    id = ibm_is_virtual_network_interface.rip_vnic_ext_vsi_gw.id
  }
  name                 = "external"
}

  resource "ibm_is_instance_network_attachment" "attach_vnic_int_gw" {
  instance = ibm_is_instance.cp_gw_vsi.id
  virtual_network_interface {
    id = ibm_is_virtual_network_interface.rip_vnic_int_vsi_gw.id
  }
  name                 = "internal"
}
