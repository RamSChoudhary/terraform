data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "test-rg" {
  name     = "test-rg"
  location = "eastus"
}

resource "azurerm_key_vault" "test-kv" {
  name                        = "test-kv1441"
  location                    = azurerm_resource_group.test-rg.location
  resource_group_name         = azurerm_resource_group.test-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }

  sku_name = "standard"
}

resource "azurerm_key_vault_key" "test-key" {
  name         = "test-key"
  key_vault_id = azurerm_key_vault.test-kv.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
