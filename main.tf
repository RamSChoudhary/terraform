
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.47.0"
    }
  }
     backend "remote" {
         # The name of your Terraform Cloud organization.
         organization = "example-organization"
#
#         # The name of the Terraform Cloud workspace to store Terraform state files in.
         workspaces {
           name = "example-workspace"
         }
       }

}

provider "azurerm" {
  # Configuration options
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "West Europe"
}   
