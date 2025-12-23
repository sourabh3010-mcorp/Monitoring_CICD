param(
    [string]$DashboardName,
    [string]$ResourceGroup,
    [string]$DashboardFilePath
)

Write-Host "Deploying Azure dashboard using ARM template..."

# Load dashboard JSON
$dashboardJson = Get-Content $DashboardFilePath -Raw | ConvertFrom-Json

# Path to ARM template
$armTemplate = "../dashboard/deploymentdashboard.json"

az deployment group create `
  --resource-group $ResourceGroup `
  --name "dashboard-$DashboardName" `
  --template-file $dashboardJson `
  --parameters dashboardName="DeploymentCICD" location="eastus"


Write-Host "Dashboard deployment completed."
