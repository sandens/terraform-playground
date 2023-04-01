variable "location" {
    type = string
    description = "The primary location for our resources"
    default = "eastus2"
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
