output "workbooks_deployed" {
  value = keys(azurerm_resource_group_template_deployment.workbooks)
}
