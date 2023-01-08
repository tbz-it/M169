###
#   Outputs wie IP-Adresse und DNS Name
#  

output "ip_vm" {
  value = module.lerncloud.ip_vm
  description = "The IP address of the server instance."
}

output "fqdn_vm" {
  value = module.lerncloud.fqdn_vm
  description = "The FQDN of the server instance."
}
  
output "description" {
  value       = module.lerncloud.description
  description = "Description VM"
}  

# Einfuehrungsseiten

output "README" {
  value = templatefile( "README.md", { ip = module.lerncloud.ip_vm, fqdn = module.lerncloud.fqdn_vm, ADDR = module.lerncloud.ip_vm } )
} 

output "ACCESSING" {
  value = templatefile( "ACCESSING.md", { ip = module.lerncloud.ip_vm, fqdn = module.lerncloud.fqdn_vm, ADDR = module.lerncloud.ip_vm } )
}    
