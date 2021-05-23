## terraform-azurerm-key-vault

[![Maintainer](https://img.shields.io/badge/maintainer%20-ingenii-orange?style=flat)](https://ingenii.dev/)
[![License](https://img.shields.io/badge/license%20-MPL2.0-orange?style=flat)](https://github.com/ingenii-solutions/terraform-azurerm-key-vault/blob/main/LICENSE)
[![Contributing](https://img.shields.io/badge/howto%20-contribute-blue?style=flat)](https://github.com/ingenii-solutions/terraform-azurerm-key-vault/blob/main/CONTRIBUTING.md)
[![Static Code Analysis](https://github.com/ingenii-solutions/terraform-azurerm-key-vault/actions/workflows/static-code-analysis.yml/badge.svg?branch=main)](https://github.com/ingenii-solutions/terraform-azurerm-key-vault/actions/workflows/static-code-analysis.yml)
[![Unit Tests](https://github.com/ingenii-solutions/terraform-azurerm-key-vault/actions/workflows/unit-tests.yml/badge.svg?branch=main)](https://github.com/ingenii-solutions/terraform-azurerm-key-vault/actions/workflows/unit-tests.yml)

## Description

This module deploys a simple Azure Key Vault with the options to apply read-write (admin) and read-only (user) permissions.

## Requirements

<!--- <<ii-tf-requirements-begin>> -->
| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2 |
<!--- <<ii-tf-requirements-end>> -->

## Example Usage

```terraform
module "key_vault" {
  source  = "ingenii-solutions/key-vault/azurerm"
  version = "x.x.x"

  name                = "myvault123"
  tags                = { Owner = "Developer" }
  resource_group_name = "rg-infrastructure"
  region              = "UKWest"

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
```

## Inputs

<!--- <<ii-tf-inputs-begin>> -->
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the Azure Key Vault. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Azure region where this Azure Key Vault will be deployed. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resrource group where the Azure Key Vault will be deployed. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Key/value pairs of tags that will be applied to all resources in this module. | `map(string)` | n/a | yes |
| <a name="input_admin_principals_object_ids"></a> [admin\_principals\_object\_ids](#input\_admin\_principals\_object\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_contacts"></a> [contacts](#input\_contacts) | Requires a list with custom object with attributes 'email', 'name', 'phone'. | <pre>list(object({<br>    email = string<br>    name  = string<br>    phone = string<br>  }))</pre> | `[]` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. | `bool` | `false` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| <a name="input_key_vault_network_acls"></a> [key\_vault\_network\_acls](#input\_key\_vault\_network\_acls) | Requires a custom object with attributes 'bypass', 'default\_action', 'ip\_rules', 'virtual\_network\_subnet\_ids'. | <pre>object({<br>    bypass                     = string<br>    default_action             = string<br>    ip_rules                   = list(string)<br>    virtual_network_subnet_ids = list(string)<br>  })</pre> | `null` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Is Purge Protection enabled for this Key Vault? | `bool` | `false` | no |
| <a name="input_read_only_principals_object_ids"></a> [read\_only\_principals\_object\_ids](#input\_read\_only\_principals\_object\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of the Azure Key Vault. | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. | `number` | `7` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The tenant id whre this Azure Key Vault will be deployed. (The tenant id will be obtained automatically from your login principal.) | `string` | `""` | no |
<!--- <<ii-tf-inputs-end>> -->

## Outputs

<!--- <<ii-tf-outputs-begin>> -->
| Name | Description |
|------|-------------|
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | The ID of the Azure Key Vault. |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | The name of the Azure Key Vault. |
| <a name="output_key_vault_uri"></a> [key\_vault\_uri](#output\_key\_vault\_uri) | The URI of the Azure Key Vault. |
<!--- <<ii-tf-outputs-end>> -->

## Nested Modules

<!--- <<ii-tf-modules-begin>> -->
No modules.
<!--- <<ii-tf-modules-end>> -->

## Resource Types

<!--- <<ii-tf-resources-begin>> -->
| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.read_only](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
<!--- <<ii-tf-resources-end>> -->

## Related Modules

* N/A

## Solutions Using This Module

* N/A
