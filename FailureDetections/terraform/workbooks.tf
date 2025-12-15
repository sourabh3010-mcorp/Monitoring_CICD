
locals {
  workbook_files = var.workbook_files
}



resource "azurerm_resource_group_template_deployment" "workbooks" {
  for_each = {
    for f in var.workbook_files :
    f => f
  }

  name                = "${var.environment}-workbook-${replace(each.key, ".json", "")}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file(
    "${path.module}/../workbooks/${lower(var.environment)}/${each.value}"
  )

  parameters_content = jsonencode({
    workbookId = {
      value = var.workbook_id[each.key]
    }
    workbookDisplayName = {
      value = "Health score ${upper(var.environment)}"
    }
    workbookType = {
      value = "workbook"
    }
    workbookSourceId = {
      value = "azure monitor"
    }
  })
}




