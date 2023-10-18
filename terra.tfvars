
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

resource_groups = {
  vm_region1 = {
    name = "example-virtual-machine-rg1"
  }
vm_region1 = {
    name = "example-virtual-machine-rg1"
  }
}
provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}

