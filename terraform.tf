terraform {
  required_version = "~> 1.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.15.0"
    }
    # restful = {
    #   source  = "magodo/restful"
    #   version = "0.14.0"
    # }
  }
}