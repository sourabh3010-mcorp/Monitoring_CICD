locals {
  dashboards = var.dashboard_files
}

resource "azapi_resource" "dashboards" {
  for_each = { for f in local.dashboards : basename(f) => f }

  type      = "Microsoft.Portal/dashboards@2022-06-01-preview"
  name      = "${var.environment}-dashboard-${replace(each.key, ".json", "")}"
  parent_id = azurerm_resource_group.rg.id

  schema_validation_enabled = false

  body = jsondecode(file("${path.module}/../dashboard/${each.value}"))
}
