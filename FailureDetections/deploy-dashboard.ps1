param(
    [string]$DashboardName,
    [string]$resource_group_name,
    [string]$DashboardFilePath
)

Write-Host "Deploying Azure Portal Dashboard: $DashboardName"

$dashboardJson = Get-Content $DashboardFilePath -Raw

az portal dashboard create `
    --name $DashboardName `
    --resource-group $resource_group_name `
    --dashboard "$dashboardJson"

Write-Host "Dashboard deployment completed."
