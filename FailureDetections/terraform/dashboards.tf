locals {
  dashboards = var.dashboard_files
}

resource "azapi_resource" "dashboards" {
  for_each = { for f in local.dashboards : basename(f) => f }

  type      = "Microsoft.Portal/dashboards@2020-09-01-preview"
  name      = "${var.environment}-dashboard-${replace(each.key, ".json", "")}"
  parent_id = azurerm_resource_group.rg.id


  body = jsondecode(file("${path.module}/../dashboard/${each.value}"))
}
