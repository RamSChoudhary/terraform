
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.47.0"
    }
  }
     backend "remote" {
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
  # Configuration options
  tenant_id       = "6247d758-84d5-49c9-b680-d24ea85bb764"
  subscription_id = "a20c6610-8802-4de7-91ff-dcd95bcbb16d"
  features {
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "West Europe"
}   
