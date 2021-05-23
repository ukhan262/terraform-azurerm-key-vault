########################################################################################################################
# Data Sources
########################################################################################################################
# Current Client Metadata
data "azurerm_client_config" "current" {}

########################################################################################################################
# Local Values
########################################################################################################################
locals {
  tenant_id = var.tenant_id != "" ? var.tenant_id : data.azurerm_client_config.current.tenant_id

  # Returns 'true' if the word 'any' exists in the IP rules list.
  is_any_acl_present = try(contains(var.key_vault_network_acls.ip_rules, "any"), false)

  /* storage_account_network_acls
  Description: Returns a specific object that sets the Firewall of the key vault to a disabled state if no custom
  Firewall rules are defined or if the word 'any' exists in the Firewall IP rules.

  Example Outputs:
  [
    {
      bypass = "AzureServices,
      default_action = "Allow",
      ip_rules = [],
      virtual_network_subnet_ids = []
    }
  ]
  */
  key_vault_network_acls = [
    local.is_any_acl_present || var.key_vault_network_acls == null || length(var.key_vault_network_acls.ip_rules) == 0 && length(var.key_vault_network_acls.virtual_network_subnet_ids) == 0 ? {
      bypass                     = "AzureServices",
      default_action             = "Allow",
      ip_rules                   = [],
      virtual_network_subnet_ids = []
    } : var.key_vault_network_acls
  ]
}

# ======================================================================================================================
# Azure Key Vault
# ======================================================================================================================
resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.region
  resource_group_name = var.resource_group_name
  tenant_id           = local.tenant_id

  sku_name = var.sku_name

  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  enable_rbac_authorization = var.enable_rbac_authorization

  # Network Rules
  dynamic "network_acls" {
    for_each = local.key_vault_network_acls
    iterator = acl
    content {
      bypass                     = acl.value.bypass
      default_action             = acl.value.default_action
      ip_rules                   = acl.value.ip_rules
      virtual_network_subnet_ids = acl.value.virtual_network_subnet_ids
    }
  }

  dynamic "contact" {
    for_each = var.contacts
    content {
      email = contact.value.email
      name  = contact.value.email
      phone = contact.value.phone
    }
  }

  tags = var.tags
}

# ======================================================================================================================
# Azure Key Vault Policies
# ======================================================================================================================
resource "azurerm_key_vault_access_policy" "read_only" {
  for_each = toset(var.read_only_principals_object_ids)

  object_id    = each.value
  tenant_id    = local.tenant_id
  key_vault_id = azurerm_key_vault.this.id

  key_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]

  certificate_permissions = [
    "Get",
    "List",
  ]
}

resource "azurerm_key_vault_access_policy" "admin" {
  for_each = toset(var.admin_principals_object_ids)

  object_id    = each.value
  tenant_id    = local.tenant_id
  key_vault_id = azurerm_key_vault.this.id

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]

  certificate_permissions = [
    "Backup",
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "Purge",
    "Recover",
    "Restore",
    "SetIssuers",
    "Update",
  ]
}