variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "us-central1"
}

variable "namespaces" {
  description = "A list of namespaces to be created in kubernetes. A map of secrets can be included e.g. {\"mysql\": {\"username\": \"johndoe\", \"password\": \"password123\"}}"
  type = list(object({
    name    = string
    secrets = map(map(string))
  }))
  default = []
}

variable "namespace_timeout" {
  description = "how long a k8s namespace operation is allowed to take before being considered a failure."
  type        = string
  default     = "5m"
}

variable "nginx_ip_names" {
  description = "Arbitrary names for list of static NGINX IPs to be created for the GKE cluster. Use empty list to avoid creating static NGINX IPs."
  type        = list(string)
  default     = []
}

variable "ingress_ip_names" {
  description = "Arbitrary names for list of static Ingress IPs to be created for the GKE cluster. Use empty list to avoid creating static Ingress IPs."
  type        = list(string)
  default     = []
}

variable "ip_address_timeout" {
  description = "how long a Compute Address operation is allowed to take before being considered a failure."
  type        = string
  default     = "5m"
}