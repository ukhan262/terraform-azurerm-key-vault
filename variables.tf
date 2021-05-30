########################################################################################################################
# REQUIRED VARIABLES
########################################################################################################################
variable "tags" {
  type        = map(string)
  description = "Key/value pairs of tags that will be applied to all resources in this module."
}

variable "name" {
  type        = string
  description = "The name of the Azure Key Vault."
  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 24
    error_message = "The name of the Azure Key Vault should be between 3 and 24 characters."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resrource group where the Azure Key Vault will be deployed."
}

variable "region" {
  type        = string
  description = "The Azure region where this Azure Key Vault will be deployed."
}

########################################################################################################################
# OPTIONAL VARIABLES
########################################################################################################################
variable "tenant_id" {
  description = "The tenant id whre this Azure Key Vault will be deployed. (The tenant id will be obtained automatically from your login principal.)"
  default     = ""
}

variable "sku_name" {
  type        = string
  description = "The SKU name of the Azure Key Vault."
  default     = "standard"
}

variable "soft_delete_retention_days" {
  type        = number
  description = "The number of days that items should be retained for once soft-deleted."
  default     = 7
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Is Purge Protection enabled for this Key Vault?"
  default     = false
}

variable "enabled_for_deployment" {
  type        = bool
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  default     = false
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys"
  default     = false
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  default     = false
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  default     = false
}

variable "key_vault_network_acls" {
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  description = "Requires a custom object with attributes 'bypass', 'default_action', 'ip_rules', 'virtual_network_subnet_ids'."
  default = {
    bypass                     = "Azure Services"
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

variable "contacts" {
  type = list(object({
    email = string
    name  = string
    phone = string
  }))
  description = "Requires a list with custom object with attributes 'email', 'name', 'phone'."
  default     = []
}

variable "read_only_principals_object_ids" {
  type        = list(string)
  description = ""
  default     = []
}

variable "admin_principals_object_ids" {
  type        = list(string)
  description = ""
  default     = []
}
