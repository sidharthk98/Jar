# Deployment for Pod A
resource "kubernetes_deployment" "deployment_pod_a" {
  metadata {
    name = "deployment-pod-a"
    labels = {
      app = "pod-a"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "pod-a"
      }
    }

    template {
      metadata {
        labels = {
          app = "pod-a"
        }
      }

      spec {
        container {
          name  = "web-server"
          image = "nginx"
          port {
            container_port = 80
          }
          env {
            name  = "POD_NAME"
            value = "Pod A"
          }
        }
      }
    }
  }
}

# Deployment for Pod B
resource "kubernetes_deployment" "deployment_pod_b" {
  metadata {
    name = "deployment-pod-b"
    labels = {
      app = "pod-b"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "pod-b"
      }
    }

    template {
      metadata {
        labels = {
          app = "pod-b"
        }
      }

      spec {
        container {
          name  = "web-server"
          image = "nginx"
          port {
            container_port = 80
          }
          env {
            name  = "POD_NAME"
            value = "Pod B"
          }
        }
      }
    }
  }
}

# Combined Deployment
resource "kubernetes_deployment" "combined_deployment" {
  metadata {
    name = "combined-deployment"
    labels = {
      app = "combined-pod"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "combined-pod"
      }
    }

    template {
      metadata {
        labels = {
          app = "combined-pod"
        }
      }

      spec {
        container {
          name  = "web-server"
          image = "nginx"
          port {
            container_port = 80
          }
          env {
            name  = "POD_A_SERVICE"
            value = "pod-a-service"
          }
          env {
            name  = "POD_B_SERVICE"
            value = "pod-b-service"
          }
        }
      }
    }
  }
}
