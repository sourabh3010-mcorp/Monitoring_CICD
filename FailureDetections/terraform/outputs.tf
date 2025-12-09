output "workbooks_deployed" {
  value = keys(azurerm_resource_group_template_deployment.workbooks)
}

output "dashboards_deployed" {
  value = keys(azurerm_resource_group_template_deployment.dashboards)
}