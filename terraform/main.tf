
## Generate a randon string
resource "random_string" "random" {
  length           = 10
  special          = false
  lower = true
  upper = false
}

resource "azurerm_resource_group" "storage_rg" {
 location = var.location
 name = var.resource_grp_name 
}

resource "azurerm_storage_account" "storage_acct" {
    location = azurerm_resource_group.storage_rg.location
    name = "${var.storage_acct_name}${random_string.random.result}" 
    account_tier = "Standard"
    account_replication_type = "LRS"
    resource_group_name=azurerm_resource_group.storage_rg.name
}

resource "azurerm_storage_container" "storage_container" {
  for_each = toset(var.containers)  
  
  storage_account_name = azurerm_storage_account.storage_acct.name
  name= "${each.value}"

}
