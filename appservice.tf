# Generate a random pet name to create a globally unique name for the App Service
resource "random_pet" "rp" {
    length = 2
}

# Create the resource group in which we will deploy the App Service
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup-${random_pet.rp.id}"
  location = "westeurope"
}

# Create the Linux App Service Plan
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "webapp-asp-${random_pet.rp.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

# Create the web app, pass in the App Service Plan ID, and deploy code from a public GitHub repo
resource "azurerm_app_service" "webapp" {
  name                = "webapp-${random_pet.rp.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id
  https_only = true
  source_control {
    repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
    branch             = "master"
    manual_integration = true
    use_mercurial      = false
  }
}

output "rg" {
  value = azurerm_resource_group.rg.name
}

output "serviceplan" {
  value = azurerm_app_service_plan.appserviceplan.sku
}

output "appservicename" {
  value = azurerm_app_service.webapp.name
}