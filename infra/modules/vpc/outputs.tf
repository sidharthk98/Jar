output "network_name" {
  description = "network name of the vpc created"
  value       = module.gcp-network.network_name
}

output "subnets_name" {
  description = "subnet list of the vpc created"
  value       = module.gcp-network.subnets_names
}
