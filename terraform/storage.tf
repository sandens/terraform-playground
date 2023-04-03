

resource "azurerm_storage_account" "bosh" {
  name                      = "stnpiplatopsomstoreus2"
  resource_group_name       = azurerm_resource_group.storage_rg.name
  location                  = azurerm_resource_group.storage_rg.location
  account_tier              = var.storage_account_tier
  account_kind              = var.storage_account_kind
  account_replication_type  = var.storage_account_replication_type
  enable_https_traffic_only = true

  tags = azurerm_resource_group.storage_rg.tags

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_advanced_threat_protection" "bosh" {
  target_resource_id = azurerm_storage_account.bosh.id
  enabled            = false

}


resource "azurerm_storage_container" "opsmanager" {
  name                  = "opsmanager"
  storage_account_name  = azurerm_storage_account.bosh.name
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.bosh]
}

resource "azurerm_storage_blob" "opsmanager" {
  name                   = "opsman-image-3.0.6.vhd"
  storage_account_name  = azurerm_storage_account.bosh.name
  storage_container_name = azurerm_storage_container.opsmanager.name
  type                   = "Page"
  source_uri             = var.opsmanager_vhd_uri
}


resource "azurerm_storage_container" "bosh" {
  name                  = "bosh"
  storage_account_name  = azurerm_storage_account.bosh.name
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.bosh]
}

resource "azurerm_storage_container" "stemcell" {
  name                  = "stemcell"
  storage_account_name  = azurerm_storage_account.bosh.name
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.bosh]
}

resource "azurerm_storage_table" "stemcells" {
  name                 = "stemcells"
  storage_account_name = azurerm_storage_account.bosh.name
  depends_on            = [azurerm_storage_account.bosh]
}


####################### TANZU ==============================

locals {
  storage_accounts = azurerm_storage_account.tanzu[*].name
  containers = var.tas_storage_containers
  
  my_product = {for val in setproduct(local.storage_accounts, local.containers):
                "${val[0]}-${val[1]}" => val}  
}

resource "azurerm_storage_account" "tanzu" {
  #for_each = toset(var.tas_storage_containers)
  count = var.tas_storage_account_number  

  name                      = "${var.tas_storage_account_prefix}${count.index}eus2"
  resource_group_name       = azurerm_resource_group.storage_rg.name
  location                  = azurerm_resource_group.storage_rg.location
  account_tier              = var.storage_account_tier
  account_kind              = var.storage_account_kind
  account_replication_type  = var.storage_account_replication_type
  enable_https_traffic_only = true

}


resource "azurerm_storage_container" "storage" {
  for_each =  local.my_product  

  name = each.value[0]
  storage_account_name  =  each.value[1]
  container_access_type = "private"
}