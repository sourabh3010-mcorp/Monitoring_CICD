environment          = "qa"
location             = "eastus"
resource_group_name  = "rg-monitoring-qa"

workbook_files = [
  "MoneyCorpView.json"
]

workbook_id = {
  "MoneyCorpView.json" = "d9f8c5c0-7a23-4c44-8d7d-f2aab9cc19c6"
}

dashboard_name = "failure-detection-dashboard-qa"
dashboard_file = "../dashboard/QA/deploymentdashboard.json"


