variable "client_id"{}

variable "client_secret"{}

variable "ssh_public_key" {}

variable "azurerm_rg_name"{
    default = "my-rg"
}

variable "azurerm_k8scluster_name" {
    default = "k8scluster"
}

variable "node_count"{
    default = 3
}