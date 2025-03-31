output "resource_group" {
  description = "The resource group created for the environment."
  value       = azurerm_resource_group.rg.name
}

output "vnet_id" {
  description = "The VNET ID from the module."
  value       = module.vnet.vnet_id
}

output "storage_account_name" {
  description = "The storage account name."
  value       = azurerm_storage_account.storage.name
}

output "vm_id" {
  description = "The Virtual Machine ID."
  value       = azurerm_linux_virtual_machine.vm.id
}
