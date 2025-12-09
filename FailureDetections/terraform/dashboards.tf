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

  # Remove 'location' key safely
  body = jsonencode(
    { for k, v in jsondecode(file("${path.module}/../dashboard/${each.value}")) : 
        k => v if k != "location"
    }
  )
}
