
# Services for Pod A, Pod B, and Combined Pod
resource "kubernetes_service" "pod_a_service" {
  metadata {
    name = "pod-a-service"
  }

  spec {
    selector = {
      app = "pod-a"
    }
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }
    type = "NodePort"
  }
}

resource "kubernetes_service" "pod_b_service" {
  metadata {
    name = "pod-b-service"
  }

  spec {
    selector = {
      app = "pod-b"
    }
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }
    type = "NodePort"
  }
}

resource "kubernetes_service" "combined_pod_service" {
  metadata {
    name = "combined-pod-service"
  }

  spec {
    selector = {
      app = "combined-pod"
    }
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }
    type = "NodePort"
  }
}
