#--------------------------------------------------
# Cresation of Network, Subnets and NSGS
#--------------------------------------------------
resource "azurerm_virtual_network" "spoke" {
 name = join("-",[
  "vnet",
  var.team_name,
  "tas",
  "01"
  ])
  
  resource_group_name =  azurerm_resource_group.storage_rg.name
  address_space       =  [var.vnet_cidr]
  location            =  azurerm_resource_group.storage_rg.location

  tags = azurerm_resource_group.storage_rg.tags
}

## Create all the subnets for the platform. Will create 5 subnets
resource "azurerm_subnet" "spoke" {

  for_each = { for obj in var.platform_subnets : obj.name => obj }

  name = join("-",[
  "snet",  
  each.value.name,
  "tas",
  "01"
  ])
 
  resource_group_name  = azurerm_resource_group.storage_rg.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [ each.value.address_prefix ]
}