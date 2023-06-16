resource "azurerm_resource_group" "Terraform" {

  name     = "Terraform-resourcegrp"
  location = "centralindia"

}
resource "azurerm_kubernetes_cluster" "webAKScluster" {
  name                = "webAKScluster"
  location            = "centralindia"
  resource_group_name = azurerm_resource_group.Terraform.name
  dns_prefix          = "webAKScluster"
  kubernetes_version  = "1.25.6"

  #node_resource_group = azurerm_resource_group.Terraform.name



  default_node_pool {

    name            = "default"

    node_count      = 1

    vm_size         = "Standard_DS2_v2"


    os_disk_size_gb = 30

  }



  service_principal {

    client_id     = "85f4c690-8f79-48bb-a917-1647925d614e"
    client_secret = "Lii8Q~E_ZMxJvOE-JDYhu3NcCGRlfK1Qn8NW7acq"


  }


  role_based_access_control_enabled = true

  tags = {

    environment = "Demoweb"

  }

}

resource "azurerm_virtual_network" "Terraform" {

  name                = "Terraform-network"

  resource_group_name = azurerm_resource_group.Terraform.name

  location            = azurerm_resource_group.Terraform.location

  address_space       = ["10.0.0.0/16"]

}


