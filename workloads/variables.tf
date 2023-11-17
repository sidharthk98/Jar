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

variable "nginx_controller" {
  description = "Whether to have a NGINX Ingress Controller installed in this cluster; with a dedicated IP. Refer to the IP name in var.nginx_ip_names to be used here."
  type = object({
    enabled = bool
    ip_name = string
  })
  default = {
    enabled = false
    ip_name = null
  }
}