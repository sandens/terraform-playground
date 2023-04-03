variable "location" {
    type = string
    description = "The primary location for our resources"
    default = "eastus2"
}

variable "team_name" {
    type=string
  
}

variable "vm_size" {
  type    = string
  default = "Standard_DS2_v2"

}

variable "vm_password" {
    sensitive = true
}
variable "vm_username" {
    type = string
}

variable "vnet_cidr" {
  type    = string
}

variable "platform_subnets" {
  type = list(map(string))
}
variable "resource_grp_name" {
    type = string
    description = "This is the resource group name"
}

variable "storage_acct_name" {
    type = string
    description = "The storage account for our stuff"   
}
variable "containers" {
    type = list(string)
}

variable "opsmanager_vhd_uri" {
  type=string
  
}


variable "tas_storage_account_prefix" {
  type = string
}

variable "tas_storage_account_number" {
  type= number
  default = 5  
}

variable "tas_storage_containers" {
  type    = list(string)
  default = ["bosh", "stemcells"]
}

variable "storage_os_disk_caching" { default = "ReadWrite" }
variable "storage_os_disk_creation_option" { default = "FromImage" }
variable "storage_os_managed_disk_type" { default = "Standard_LRS" }


variable "cloud_name" {
  description = "The Azure cloud environment to use. Available values at https://www.terraform.io/docs/providers/azurerm/#environment"
  default     = "public"
  type        = string
}

variable "tags" {
  description = "Key/value tags to assign to all resources."
  default     = {}
  type        = map(string)
}


variable "storage_account_tier" {
  default = "Standard"
  type    = string
}

variable "storage_account_kind" {
  default = "StorageV2"
  type    = string
}

variable "storage_account_replication_type" {
  default = "GZRS"
  type    = string
}

variable "iaas_configuration_environment_azurecloud" {
  default = "AzureCloud"
  type    = string
}
