variable "resource_group_name_prefix" {
  type    = string
  default = "resource-group"
}

variable "location" {
  type    = string
  default = "East Europe"
}

variable "storage_account_replication_type" {
  type    = string
  default = "LRS"
}

variable "storage_account_account_tier" {
  type    = string
  default = "Standard"
}

variable "storage_account_name_suffix" {
  type    = string
  default = "storage-account"
}

variable "service_plan_name_suffix" {
  type    = string
  default = "service_plan"
}

variable "service_plan_os_type" {
  type    = string
  default = "Linux"
}

variable "service_plan_sku_name" {
  type    = string
  default = "B1"
}

variable "linux_function_app_name_suffix" {
  type    = string
  default = "linux_function_app"
}

variable "app_function_name_suffix" {
  type    = string
  default = "app_function"
}

variable app_function_config {
  type = object({})
  default = {
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "methods"   = [
          "get",
          "post",
        ]
        "name" = "req"
        "type" = "httpTrigger"
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  }
}
