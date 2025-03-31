resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    region      = var.location
  }
}

module "vnet" {
  source              = "../../modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_name           = "vnet-${var.environment}-${var.location}"
  address_space       = ["10.0.0.0/16"]
  subnets = [
    {
      name           = "subnet-default"
      address_prefix = "10.0.1.0/24"
    }
  ]
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_storage_account" "storage" {
  name                      = "st${var.environment}${replace(var.location, " ", "")}${random_string.suffix.result}"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  is_hns_enabled            = true
  min_tls_version           = "TLS1_2"

  tags = {
    environment = var.environment
    region      = var.location
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.environment}-${var.location}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = module.vnet.subnet_ids["subnet-default"]
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = var.environment
    region      = var.location
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${var.environment}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  disable_password_authentication = true

  tags = {
    environment = var.environment
    region      = var.location
  }
}
