locals {
  workbook_files = var.workbook_files
}

resource "azurerm_resource_group_template_deployment" "workbooks" {
  for_each = {
    for f in local.workbook_files :
    basename(f) => f
  }

  name                = "${var.environment}-workbook-${replace(each.key, ".json", "")}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/../workbooks/${each.value}")
  parameters_content = jsonencode({})
}
