resource "azurerm_virtual_network" "test-vnet" {
  name                = "test-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name
}

resource "azurerm_subnet" "test-sn" {
  name                 = "test-sn"
  resource_group_name  = azurerm_resource_group.test-rg.name
  virtual_network_name = azurerm_virtual_network.test-vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  enforce_private_link_service_network_policies = true
}

resource "azurerm_private_endpoint" "test-pe" {
  name                = "test-pe"
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name
  subnet_id           = azurerm_subnet.test-sn.id

  private_service_connection {
    name                           = "test-pe-conn"
    private_connection_resource_id = azurerm_key_vault.test-kv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  
  lifecycle {
    ignore_changes = [
      private_dns_zone_group,
    ]
  }
}

resource "azurerm_private_dns_zone" "main" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.test-rg.name
}

resource "azurerm_private_dns_a_record" "pe_kv" {
  name                = "kv.dns"
  zone_name           = azurerm_private_dns_zone.main.name
  resource_group_name = azurerm_resource_group.test-rg.name
  ttl                 = 300
  records             = ["1.2.3.4"]
}

output kv_private_ip {
  value =   ["1.2.3.4"]
}

resource "null_resource" "dns_update" {
  triggers = {
    priv_fqdn = "${azurerm_private_endpoint.private_endpoint[0].custom_dns_configs[0].fqdn}"
    priv_ip   = "${azurerm_private_endpoint.private_endpoint[0].custom_dns_configs[0].ip_addresses[0]}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
      echo ${self.triggers.priv_fqdn}
      bash ${path.module}/dns_update.sh destroy ${self.triggers.priv_fqdn}
    EOF
  }

  provisioner "local-exec" {
    command = <<EOF
      echo ${self.triggers.priv_fqdn}
      echo ${self.triggers.priv_ip}
      bash ${path.module}/dns_update.sh apply ${self.triggers.priv_fqdn} ${self.triggers.priv_ip}
      bash ${path.module}/dns_update.sh get ${self.triggers.priv_fqdn}
    EOF
  }
}
