resource "azurerm_resource_group" "my-rg" {
    name = var.azurerm_rg_name
    location = "eastus"
}

resource "azurerm_kubernetes_cluster" "k8scluster" {
  name                = var.azurerm_k8scluster_name
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  dns_prefix          = "k8scluster"


  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }


  default_node_pool {
    name       = "agentpool"
    node_count = var.node_count
    vm_size    = "Standard_D2_v2"
    enable_auto_scaling = "false"
  }

  service_principal {
    client_id = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    environment = production
  }
}

resource "azurerm_storage_account" "aksstorage" {
    name = "aksstorage"
    location = azurerm_resource_group.my-rg.location
    resource_group_name = azurerm_resource_group.my-rg.location
    account_replication_type = Standard_LRS
}



terraform {
backend "azurerm" {
    //container_name = "aksstorage"
    //storage_account_name = "aksstorage"
    //key = "aksstorage.tfstate"
    //access_key = 
}
}