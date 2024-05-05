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

variable "storage_container_name_suffix" {
  type    = string
  default = "storage-container"
}

variable "storage_blob_name_suffix" {
  type    = string
  default = "storage-blob"
}

variable "storage_blob_type" {
  type    = string
  default = "APPEND"
}
