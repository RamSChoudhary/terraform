data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "test-rg" {
#count = length(var.resource_groups) == length(distinct([keys(var.resource_groups)])) ? var.resource_groups : {}
  name     = "testeeeeeeet"
  location = "eastus"
#lifecycle{
#  precondition {
#    condition     =length(distinct([keys(var.resource_groups)])) == length(var.resource_groups)
#    error_message = "Duplicate key in the map variable."
#  }
#postcondition {
#    condition     =length(distinct([keys(var.resource_groups)])) == length(var.resource_groups)
#    error_message = "Duplicate key in the map variable.post"
#  }
#}
}

#resource "azurerm_key_vault" "test-kv" {
#  name                          = "test-kv1441"
#  location                      = azurerm_resource_group.test-rg.location
#  resource_group_name           = azurerm_resource_group.test-rg.name
#  enabled_for_disk_encryption   = true
#  tenant_id                     = data.azurerm_client_config.current.tenant_id
#  soft_delete_retention_days    = 7
#  purge_protection_enabled      = false
#  public_network_access_enabled = false

#  access_policy {
#    tenant_id = data.azurerm_client_config.current.tenant_id
#    object_id = data.azurerm_client_config.current.object_id

#    key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
#    secret_permissions      = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
#    certificate_permissions = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
#    storage_permissions     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]

#  }

#  sku_name = "standard"

  #tags   = {
  #  "environment" : "test"
  #  "project": "test"
  #   "owner" : "test"
#}

#  lifecycle {
#    ignore_changes = [ public_network_access_enabled ]
#  }
#}

#resource "azurerm_key_vault_key" "test-key" {
#  name         = "test-key"
#  key_vault_id = azurerm_key_vault.test-kv.id
#  key_type     = "RSA"
#  key_size     = 2048

#  key_opts = [
#    "decrypt",
#    "encrypt",
#    "sign",
#    "unwrapKey",
#    "verify",
#    "wrapKey",
#  ]

  

  #depends_on = [null_resource.kv-keys-add]
#}

#resource "null_resource" "kv-keys-add" {
  #  # Changes to any instance of the cluster requires re-provisioning
#  triggers = {
    # key_name        = azurerm_key_vault_key.test-key.name
#    key_vault_name = azurerm_key_vault.test-kv.id
#    always_run     = "${timestamp()}"
#  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  #connection {
  #host = element(aws_instance.cluster.*.public_ip, 0)
  #}

#  provisioner "local-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    #command     = "chmod +x ${path.cwd}/script.sh;"
#    command     = <<EOT
#    agentIP=$(curl -s https://api.ipify.org/)

#    az keyvault network-rule add --resource-group test-rg --name test-kv1441 --ip-address $agentIP

#    sleep 40s
#    echo $agentIP
#    EOT
    #interpreter = ["bash", "-c"]


#  }
#}

#data "local_file" "ip" {
#  filename   = "${path.module}/ip.txt"
#  depends_on = [null_resource.kv-keys-add]
#}
