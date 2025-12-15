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


variable "workbook_id" {
  type = map(string)
  description = "A map of workbook filename => workbook ID"
}

variable "dashboard_name" {
  description = "Name of the Azure Portal dashboard"
  type        = string
}

variable "dashboard_file" {
  description = "Path to the Azure dashboard JSON file"
  type        = string
  default     = "../dashboard/dashboard.json"
}

variable "workbook_display_name" {
  type = map(string)
  description = "Mapping of workbook file to display name"
}