variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "us-central1"
}

variable "network_name" {
  description = "The VPC network created to host the cluster in"
}

variable "subnets_name" {
  description = "The subnetwork created to host the cluster in"
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-svc"
}

variable "service_account_email" {
  description = "Name of the service account assigned to the node pool"
}