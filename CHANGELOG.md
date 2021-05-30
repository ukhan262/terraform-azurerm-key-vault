## 0.0.4

BUG FIXES:

- **Variables Update:** Provide a sufficient default for the key_vault_network_acls variable. Previously defined null value was causing the module to fail deployment
  if the variable was not defined by the calling module.

## 0.0.3

IMPROVEMENTS:

- **Template Update:** Updating to the latest Cruft template.

## 0.0.2

BUG FIXES:

- **Validation:** Fixed the validation condition of the key vault to include the min and max values.

## 0.0.1

NEW FEATURES:

- **General:** A working deployment of the Azure Key Vault.
- **General:** Ability to assign permissions.
