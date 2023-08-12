terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# Variables
variable "resource_group_name" {}
variable "azurerm_subnet_name" {} #In terraform.tfvars
variable "vm_computer_name" {}
variable "vm_admin_username" {}
variable "vm_admin_password" {}


# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "ExampleInc"
  address_space       = ["10.0.0.0/16"]
  location            = "Central US"
  resource_group_name = var.resource_group_name
  tags = {
    Environment = "ExampleEnv"
    Team        = "ExampleTeam"
  }
}

# Create Subnet
resource "azurerm_subnet" "Subnet" {
  name                 = var.azurerm_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Public IP
resource "azurerm_public_ip" "example" {
  name                = "example-pip"
  location            = "Central US"
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

# Create a Network Interface
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = "Central US"
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

# Virtual Machine
resource "azurerm_virtual_machine" "vm" {
  name                  = "ExampleVM"
  location              = "Central US"
  resource_group_name   = var.resource_group_name
  vm_size               = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.example.id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  
  os_profile {
    computer_name  = var.vm_computer_name
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
  }

   os_profile_linux_config {
    disable_password_authentication = false
  }
}

