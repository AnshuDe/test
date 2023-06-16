terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }


  }
}
# variable "client_secret" {
# }


# Azure Provider source and version being used

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "85f4c690-8f79-48bb-a917-1647925d614e"
  client_secret   = "Lii8Q~E_ZMxJvOE-JDYhu3NcCGRlfK1Qn8NW7acq"
  tenant_id       = "4ec9e9d4-1dad-427f-adf9-e774dca413d1"
  subscription_id = "0d0019e5-9c82-4a1e-be5e-6ca782ecf637"

}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}