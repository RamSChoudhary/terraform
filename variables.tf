
variable "global_settings" {
  default = {}
}
variable "resource_groups" {
  default = {}
}
variable "provider_azurerm_features_keyvault" {
  default = {
    purge_soft_delete_on_destroy = true
  }
}

variable "enable_private_endpoint" {

}