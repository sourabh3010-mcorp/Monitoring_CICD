environment          = "prod"
location             = "eastus2"
resource_group_name  = "rg-monitoring-prd"

workbook_files = [
  "workbook-aks.json",
  "workbook-infra.json"
]
