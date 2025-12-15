environment          = "qa"
location             = "eastus"
resource_group_name  = "rg-monitoring-qa"

workbook_files = [
  "MoneyCorpView.json",
  "workbook2.json"
]

workbook_id = {
  "MoneyCorpView.json" = "d9f8c5c0-7a23-4c44-8d7d-f2aab9cc19c6",
  "workbook2.json" = "f1c2d3a4-9b87-4e6f-8c5d-2a7b1e9f0d34"
}

workbook_display_name = {
  "MoneyCorpView.json" = "Money Corp Health Score"
  "workbook2.json"  = "Payments Overview"
}

dashboard_name = "failure-detection-dashboard-qa"
dashboard_file = "../dashboard/QA/deploymentdashboard.json"



