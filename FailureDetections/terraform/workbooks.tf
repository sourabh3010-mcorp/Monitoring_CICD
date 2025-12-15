locals {
  # Path to environment-specific workbooks
  workbooks_path = "${path.module}/workbooks/${lower(var.environment)}"
}

resource "azurerm_resource_group_template_deployment" "workbooks" {
  for_each = {
    for f in var.workbook_files :
    f => f
  }

  name                = "${var.environment}-workbook-${replace(each.key, ".json", "")}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${local.workbooks_path}/${each.value}")

  parameters_content = jsonencode({
    workbookId = {
      value = var.workbook_id[each.key]
    }
    workbookDisplayName = {
      value = var.workbook_display_name[each.key]
    }
    workbookType = {
      value = "workbook"
    }
    workbookSourceId = {
      value = "azure monitor"
    }
  })
}