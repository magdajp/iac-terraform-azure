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

resource "azurerm_service_plan" "service_plan" {
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  name                = "${azurerm_resource_group.resource_group.name}-${var.service_plan_name_suffix}"
  os_type             = var.service_plan_os_type
  sku_name            = var.service_plan_sku_name
}

resource "azurerm_linux_function_app" "linux_function_app" {
  resource_group_name  = azurerm_resource_group.resource_group.name
  location             = var.location
  name                 = "${azurerm_resource_group.resource_group.name}-${var.linux_function_app_name_suffix}"
  service_plan_id      = azurerm_service_plan.service_plan.id
  storage_account_name = azurerm_storage_account.storage_account.name
  site_config {}
}

resource "azurerm_function_app_function" "app_function" {
  name            = "${azurerm_resource_group.resource_group.name}-${var.app_function_name_suffix}"
  config_json     = jsonencode(var.app_function_config)
  function_app_id = azurerm_linux_function_app.linux_function_app.id
}
