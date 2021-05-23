terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  tags = {
    Owner       = "Ingenii"
    Environment = "Development"
    Description = "This resources belongs to automated testing environment."
  }
  random_string = lower(random_string.this.result)
}

resource "random_string" "this" {
  length  = 8
  number  = false
  special = false
}

resource "azurerm_resource_group" "this" {
  location = "UKSouth"
  name     = title(local.random_string)
}

module "key_vault" {
  source              = "../../../"
  name                = local.random_string
  tags                = local.tags
  resource_group_name = azurerm_resource_group.this.name
  region              = azurerm_resource_group.this.location

  admin_principals_object_ids     = []
  read_only_principals_object_ids = []

  # Network Rules
  key_vault_network_acls = {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

output "random_string" {
  value = local.random_string
}
output "name" {
  value = module.key_vault.key_vault_name
}