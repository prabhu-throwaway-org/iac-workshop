# This is the input variables file for the app service

# prefix for app service and app service plan 
variable "prefix" {
  type        = string
  description = "this prefix will be used in the naming of app service and app service plan"
  default     = "webapp"
}

# region we will deploy to
variable "location" {
  type        = string
  description = "the region we will be deploying our services in"
  default     = "westeurope"
}

variable "app_service_tier" {
  type        = string
  description = "the tier for app service plan"
  default     = "Free"
}

variable "app_service_size" {
  type        = string
  description = "the tier for app service plan"
  default     = "F1"
}

