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

variable "alert_rule_name_1" {
  description = "Name of the Alert Rule 1"
  type        = string
}

variable "alert_rule_name_2" {
  description = "Name of the Alert Rule 2"
  type        = string
}

variable "alert_rule_name_3" {
  description = "Name of the Alert Rule 3"
  type        = string
}

variable "alert_emails" {
  type        = list(string)
  description = "List of email addresses for alert notifications"
}