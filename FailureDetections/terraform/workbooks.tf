
locals {
  workbooks_path = "${path.module}/../workbooks/${lower(var.environment)}"

  workbook_files = var.workbook_files
}

locals {
  missing_files = [
    for f in var.workbook_files :
    f if !fileexists("${local.workbooks_path}/${f}")
  ]
}

resource "null_resource" "validate_workbooks" {
  count = length(local.missing_files) > 0 ? 1 : 0

  provisioner "local-exec" {
    command = "echo Missing workbook files: ${join(", ", local.missing_files)} && exit 1"
  }
}

resource "azurerm_resource_group_template_deployment" "workbooks" {
  for_each = {
    for f in local.workbook_files :
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
      value = "Health score ${var.environment}"
    }
    workbookType = {
      value = "workbook"
    }
    workbookSourceId = {
      value = "azure monitor"
    }
  })
}


