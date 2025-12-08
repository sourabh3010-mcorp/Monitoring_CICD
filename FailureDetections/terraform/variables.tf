variable "environment" {
  description = "Deployment environment (e.g. qa or prod). Provided by the pipeline."
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "workbook_files" {
  type        = list(string)
  description = "List of workbook json files"
}