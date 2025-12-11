resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "null_resource" "deploy_dashboard" {
  triggers = {
    dashboard_hash = filesha256(var.dashboard_file)
    environment    = var.environment
  }

  provisioner "local-exec" {
    interpreter = ["pwsh", "-Command"]

    command = "../deploy-dashboard.ps1 -DashboardName '${var.dashboard_name}' -ResourceGroup '${var.resource_group_name}' -DashboardFilePath '${var.dashboard_file}'"
  }
}