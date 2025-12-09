locals {
  dashboard_files = var.dashboard_files
}

resource "azapi_resource" "dashboards" {
  for_each = { for f in local.dashboard_files : basename(f) => f }

  type      = "Microsoft.Portal/dashboards@2022-06-01-preview"
  name      = "${var.environment}-dashboard-${replace(each.key, ".json", "")}"
  parent_id = azurerm_resource_group.rg.id
  location  = var.location

  # Disable schema validation to allow newer API versions
  schema_validation_enabled = false

  # Safely remove 'location' from JSON body
  body = jsonencode(
    merge(
      tomap(jsondecode(file("${path.module}/../dashboard/${each.value}")))...
      , { "location" = null } # this effectively removes it
    )
  )
}

output "dashboards_deployed" {
  value = keys(azapi_resource.dashboards)
}
