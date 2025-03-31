variable "resource_group_name" {
  description = "Resource group name for the environment."
  type        = string
  default     = "rg-dev-eastus"
}

variable "location" {
  description = "Azure region for deployment."
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}
