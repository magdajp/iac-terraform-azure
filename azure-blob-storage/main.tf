terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

resource "random_pet" "group_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "resource_group" {
  name     = random_pet.group_name.id
  location = var.location
}

resource "azurerm_storage_account" "storage_account" {
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = var.location
  name                     = "${azurerm_resource_group.resource_group.name}-${var.storage_account_name_suffix}"
  account_replication_type = var.storage_account_replication_type
  account_tier             = var.storage_account_account_tier
}

resource "azurerm_storage_container" "storage_container" {
  name                 = "${azurerm_resource_group.resource_group.name}-${var.storage_container_name_suffix}"
  storage_account_name = azurerm_storage_account.storage_account.name
}

resource "azurerm_storage_blob" "storage_blob" {
  name                   = "${azurerm_resource_group.resource_group.name}-${var.storage_blob_name_suffix}"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = var.storage_blob_type
}
