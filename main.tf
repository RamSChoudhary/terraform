
terraform {
  #required_providers {
  #  azurerm = {
  #    source = "hashicorp/azurerm"
  #    version = "3.47.0"
  #  }
  #}
  required_providers {
  }
  required_version = ">= 1.1.0"
     cloud {
         # The name of your Terraform Cloud organization.
         organization = "Learning1441"
#
#         # The name of the Terraform Cloud workspace to store Terraform state files in.
         workspaces {
           name = "terraform"
         }
       }

}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = var.provider_azurerm_features_keyvault.purge_soft_delete_on_destroy
      recover_soft_deleted_key_vaults = true
    }
  }
}

#provider "azurerm" {
  # Configuration options
  #tenant_id       = "6247d758-84d5-49c9-b680-d24ea85bb764"
  #subscription_id = "a20c6610-8802-4de7-91ff-dcd95bcbb16d"
 # features {
 # }
#}

#resource "azurerm_resource_group" "example" {
#  name     = "example"
#  location = "West Europe"
#}

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.3.11"

  global_settings = var.global_settings
  resource_groups = var.resource_groups
 }
