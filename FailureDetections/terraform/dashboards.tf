locals {
  dashboard_files = var.dashboard_files
}


resource "azurerm_dashboard" "dashboards" {
  for_each = { for f in local.dashboard_files : basename(f) => f }

  name                = "deployment-dashboard"
  resource_group_name = var.resource_group_name
  location            = var.location

  dashboard_properties = file(abspath("${path.module}/../dashboard/${each.value}"))
}

