terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {}
}

# Create a Resource Group
resource "azurerm_resource_group" "tf-test" {
  name     = "tfmainrg"
  location = "Germany West Central"
}



resource "azurerm_container_group" "tfcg_test" {
    name="weatherapi"
    location = azurerm_resource_group.tf-test.location
    resource_group_name = azurerm_resource_group.tf-test.name

    ip_address_type = "Public"
    os_type = "Linux"
    dns_name_label = "weatherapi-bhatti"

    container {
        name   = "weatherapi"
        image  = "psbhatti/weatherapi"
        cpu    = "1"
        memory = "1"


        ports {
            port     = 8080
            protocol = "TCP"
        }
  }
}