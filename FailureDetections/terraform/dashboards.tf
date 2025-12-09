locals {
  dashboard_files = var.dashboard_files
}



resource "azurerm_resource_group_template_deployment" "dashboards" {
  for_each = { for f in local.dashboard_files : basename(f) => f }

  name                = "${var.environment}-dashboard-${replace(each.key, ".json", "")}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file(abspath("${path.module}/../dashboard/${each.value}"))

  parameters_content = jsonencode({})
}

