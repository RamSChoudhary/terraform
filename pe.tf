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
