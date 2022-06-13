# Generate a random pet name to create a globally unique name for the App Service
resource "random_pet" "unique_name" {
  length = 2
}

# Create the resource group in which we will deploy the App Service
resource "azurerm_resource_group" "demo" {
  name = "terraform-demo-rg"
  #location = var.location
  location = "westeurope"
}

# Create the Linux App Service Plan
resource "azurerm_app_service_plan" "demo" {
  name                = "terraform-demo-plan"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  # sku {
  #   tier = var.app_service_tier
  #   size = var.app_service_size
  # }
  sku {
    tier = "Free"
    size = "F1"
  }
}

# Create the web app, pass in the App Service Plan ID, and deploy code from a public GitHub repo
resource "azurerm_app_service" "webapp" {
  name                = "webapp-${random_pet.unique_name.id}"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  app_service_plan_id = azurerm_app_service_plan.demo.id
  https_only          = true
  source_control {
    repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
    branch             = "master"
    manual_integration = true
    use_mercurial      = false
  }
}

# These blocks defines and prints the outputs from the terraform deployment script. This output block is also called as "Output Variables" in Terraform

# Setting output for resource group
output "rg" {
  value = azurerm_resource_group.rg.name
}

# Setting output for app service plan
output "appservice_serviceplan" {
  value = azurerm_app_service_plan.demo.sku
}

# Setting output for app service name
output "appservice_name" {
  value = azurerm_app_service.webapp.name
}

# Setting putput for the appservice website
output "appservice_website" {
  value = azurerm_app_service.webapp.default_site_hostname
}
