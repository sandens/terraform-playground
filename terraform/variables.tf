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
