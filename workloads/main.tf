locals {
    k8s_secrets = flatten([
    for namespace_obj in var.namespaces : [
      for secret_name, secret_data in namespace_obj.secrets : {
        namespace_name = namespace_obj.name
        secret_name    = secret_name
        secret_data    = secret_data
    }]])
  nginx_ports = length(distinct(var.nginx_ip_names)) == 0 ? [] : [
    "8443" # see https://kubernetes.github.io/ingress-nginx/deploy/#gce-gke
  ]
}

resource "google_project_service" "container_api" {
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "networking_api" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

data "google_client_config" "default" {}


data "google_container_cluster" "gke" {
  project = var.project_id
  name     = "gke-test"
  location = var.region
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.gke.master_auth[0].cluster_ca_certificate)
}

resource "kubernetes_namespace" "namespaces" {
  for_each = { for obj in var.namespaces : obj.name => obj }
  metadata {
    name   = each.value.name
  }
  timeouts { delete = var.namespace_timeout }
}

resource "kubernetes_secret" "secrets" {
  for_each = { for obj in local.k8s_secrets : "${obj.namespace_name}:${obj.secret_name}" => obj }
  metadata {
    namespace = each.value.namespace_name
    name      = each.value.secret_name
  }
  data       = each.value.secret_data
  depends_on = [kubernetes_namespace.namespaces]
}

module "deployments" {
  source = "./deployments"
  depends_on = [ kubernetes_namespace.namespaces ]
}

module "services" {
  source = "./services"
  depends_on = [ kubernetes_namespace.namespaces ]
}

resource "google_compute_address" "static_nginx_ip" {
  for_each   = toset(var.nginx_ip_names)
  name       = format("nginx-%s", each.value)
  depends_on = [google_project_service.networking_api]
  region       = "us-central1"
  timeouts {
    create = var.ip_address_timeout
    delete = var.ip_address_timeout
  }
}

# resource "null_resource" "export_kubeconfig" {
#   provisioner "local-exec" {
#     command = <<-EOT
#       gcloud container clusters get-credentials gke-test --region ${var.region} --project ${var.project_id}
#       export KUBECONFIG_PATH=~/.kube/config
#     EOT
#   }
#   depends_on = [data.google_container_cluster.gke]
# }

resource "helm_release" "nginx_ingress_controller" {
  # see https://kubernetes.github.io/ingress-nginx/deploy/#using-helm
  count            = var.nginx_controller.enabled ? 1 : 0
  name             = "nginx-ingress"
  namespace        = "nginx-ingress"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.0.1"
  values = [
    # values.yaml file contents copied from official repo at https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.0.1
    file("${path.module}/helm/nginx-ingress-values.yaml")
  ]
  set_sensitive {
    name  = "controller.service.loadBalancerIP"
    value = google_compute_address.static_nginx_ip[var.nginx_controller.ip_name].address
  }
  depends_on = [google_compute_address.static_nginx_ip]
}