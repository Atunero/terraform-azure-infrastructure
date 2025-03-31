variable "resource_group_name" {
  description = "Name of the resource group in which to create the VNET."
  type        = string
}

variable "location" {
  description = "Azure region for the VNET."
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "List of CIDR blocks for the VNET."
  type        = list(string)
}

variable "subnets" {
  description = "List of subnet definitions."
  type = list(object({
    name           = string
    address_prefix = string
    nsg_id         = optional(string)
  }))
  default = []
}
