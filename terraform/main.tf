terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    storage_account_name  = "__terraformstorageaccount__"
    container_name        = "terraform"
    key                   = "terraform.tfstate"
    access_key            = "__storagekey__"
  }
  
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Configure Azure Resource Group 
resource "azurerm_resource_group" "rg" {
  name     = "PULTerraform"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "dev" {
  name                = "__appserviceplan__"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  sku {
    tier = "Free"
    size = "F1"
  }

}

resource "azurerm_app_service" "dev" {
  name                = "__appservicename__"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  app_service_plan_id = "${azurerm_app_service_plan.dev.id}"
}