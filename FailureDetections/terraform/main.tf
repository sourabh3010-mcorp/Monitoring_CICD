locals {
  # Path to environment-specific workbooks
  workbooks_path = "${path.module}/workbooks/${lower(var.environment)}"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "time_sleep" "after_rg" {
  depends_on = [azurerm_resource_group.rg]

  create_duration = "30s"

  triggers = {
    always_run = timestamp()
  }

}


resource "azurerm_resource_group_template_deployment" "workbooks" {
  for_each = {
    for f in var.workbook_files :
    f => f
  }

    depends_on = [time_sleep.after_rg]

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

resource "time_sleep" "after_workbooks" {
  depends_on = [azurerm_resource_group_template_deployment.workbooks]

  create_duration = "30s"

  triggers = {
    always_run = timestamp()
  }

}

resource "null_resource" "deploy_dashboard" {
  depends_on = [time_sleep.after_workbooks]


  triggers = {
    environment    = var.environment
  }

  provisioner "local-exec" {
    interpreter = ["pwsh", "-Command"]

    command = "../deploy-dashboard.ps1 -DashboardName '${var.dashboard_name}' -ResourceGroup '${var.resource_group_name}' -DashboardFilePath '${var.dashboard_file}'"
  }
}

resource "azurerm_monitor_action_group" "failure_ag" {
  name                = "${var.environment}-failure-detection-ag"
  resource_group_name = var.resource_group_name
  short_name          = "failagcicd"

  dynamic "email_receiver" {
    for_each = var.alert_emails
    content {
      name          = "email-${replace(email_receiver.value, "@", "-")}"
      email_address = email_receiver.value
    }
  }

  tags = {
    Environment = var.environment
  }
}



resource "azurerm_resource_group_template_deployment" "log_alerts" {
  name                = "log-alerts-arm-deployment"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/alert_rules/template.json")

  parameters_content = jsonencode({
    alert_rule_name_1 = {
      value = var.alert_rule_name_1
    }
    alert_rule_name_2 = {
      value = var.alert_rule_name_2
    }
    alert_rule_name_3 = {
      value = var.alert_rule_name_3
    }

    actiongroups_test_ag_externalid = {
      value = azurerm_monitor_action_group.failure_ag.id
    }
  })
}

