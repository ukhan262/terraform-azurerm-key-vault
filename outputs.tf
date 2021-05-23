########################################################################################################################
# OUTPUTS
########################################################################################################################

output "key_vault_name" {
  value       = azurerm_key_vault.this.name
  description = "The name of the Azure Key Vault."
}

output "key_vault_id" {
  value       = azurerm_key_vault.this.id
  description = "The ID of the Azure Key Vault."
}

output "key_vault_uri" {
  value       = azurerm_key_vault.this.vault_uri
  description = "The URI of the Azure Key Vault."
}

########################################################################################################################
# SENSITIVE OUTPUTS
########################################################################################################################
