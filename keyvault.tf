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
  public_network_access_enabled = false
  
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    
    key_permissions         = ["Backup","Create","Decrypt","Delete","Encrypt","Get","Import","List","Purge","Recover","Restore","Sign","UnwrapKey","Update","Verify","WrapKey","Release","Rotate","GetRotationPolicy","SetRotationPolicy"]
    secret_permissions      = ["Backup","Delete","Get","List","Purge","Recover","Restore","Set"]
    certificate_permissions = ["Backup","Create","Delete","DeleteIssuers","Get","GetIssuers","Import","List","ListIssuers","ManageContacts","ManageIssuers","Purge","Recover","Restore","SetIssuers","Update"]
    storage_permissions     = ["Backup","Delete","DeleteSAS","Get","GetSAS","List","ListSAS","Purge","Recover","RegenerateKey","Restore","Set","SetSAS","Update"]
  
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


# resource "null_resource" "cluster" {
#   # Changes to any instance of the cluster requires re-provisioning
#   triggers = {
#     cluster_instance_ids = join(",", aws_instance.cluster.*.id)
#   }

#   # Bootstrap script can run on any instance of the cluster
#   # So we just choose the first in this case
#   connection {
#     host = element(aws_instance.cluster.*.public_ip, 0)
#   }

#   provisioner "remote-exec" {
#     # Bootstrap script called with private_ip of each node in the cluster
#     inline = [
#       "agentIP=$(curl -s https://api.ipify.org/) 
#       az keyvault network-rule add --resource-group test-rg --name test-kv1441 --ip-address $agentIP"
#       ,
#     ]
#   }
# }
