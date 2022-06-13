# # This file defines and prints the outputs from the terraform deployment script. This output block is also called as "Output Variables" in Terraform

# # Setting output for resource group
# output "rg" {
#   value = azurerm_resource_group.rg.name
# }

# # Setting output for app service plan
# output "appservice_serviceplan" {
#   value = azurerm_app_service_plan.appserviceplan.sku
# }

# # Setting output for app service name
# output "appservice_name" {
#   value = azurerm_app_service.webapp.name
# }

# # Setting putput for the appservice website
# output "appservice_website" {
#   value = azurerm_app_service.webapp.default_site_hostname
# }