
resource "tls_private_key" "opsmgr" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "azurerm_network_interface" "opsmgr" {
    name = join("-",[
    "vnic",
    var.team_name,
    "opsmanager",
    "01"
    ])
     resource_group_name = azurerm_resource_group.storage_rg.name
     location = azurerm_resource_group.storage_rg.location

   ip_configuration {
    name                          = "ipconfig-opsmgr-vm"
    subnet_id                     =  azurerm_subnet.spoke["management"].id
    private_ip_address_allocation = "Static"
  } 
   depends_on = [
     azurerm_subnet.spoke
   ]
}

##-------------------------------------------
# Create the BOSH Director VM
##-------------------------------------------
resource "azurerm_linux_virtual_machine" "opsmgr" {
    name = join("-",[
    "vm",
    var.team_name,
    "opsmanager",
    "01"
  ])
    resource_group_name =  azurerm_resource_group.storage_rg.name
    location = azurerm_resource_group.storage_rg.location
    network_interface_ids = [azurerm_network_interface.opsmgr.id]
    size = var.vm_size
    
  source_image_id = azurerm_image.bosh.id
  
  os_disk {
    name                 = "ops-manager-3.0.6-build.269"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  admin_username = var.vm_username
  admin_password = var.vm_password

  admin_ssh_key {
    username   = "ubuntu"
    public_key = tls_private_key.opsmgr.public_key_openssh
  }   
  
  tags = azurerm_resource_group.storage_rg.tags

   depends_on = [
       azurerm_network_interface.opsmgr
   ]
}

resource "azurerm_image" "bosh" {
  name = join("-",[
    "img",
    var.team_name,
    "opsmanager306",
    "01"
  ])
  location            = azurerm_resource_group.storage_rg.location
  resource_group_name = azurerm_resource_group.storage_rg.name

  os_disk {
    os_type  = "Linux"
    os_state = "Generalized"
    blob_uri = "https://staccountgl0q0z44yo.blob.core.windows.net/images/opsman-image-3.0.6.vhd"
    size_gb  = 30
  }
}


##--------------------------------------------------
# Create the VM Network Interface Card for the VM
##--------------------------------------------------


