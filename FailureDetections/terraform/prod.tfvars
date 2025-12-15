environment          = "prod"
location             = "eastus2"
resource_group_name  = "rg-monitoring-prd"

workbook_files = [
  "MoneyCorpViewPROD.json"
]


workbook_id = {
  "MoneyCorpView.json" = "a3e7b9f2-4d61-4a8c-9f2b-7c1e5d8a4b90"
}

dashboard_name = "failure-detection-dashboard-prod"
dashboard_file = "../dashboard/PROD/deploymentdashboardprod.json"