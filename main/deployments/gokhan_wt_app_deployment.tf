resource "kubernetes_deployment" "gokhan_wt_app_deployment" {
  metadata {
    name = "gokhan-wt-app-deployment"
    labels = {
      app = "gokhan-wt-app"
    }
  }
  spec {
    replicas = var.gokhan_wt_app_deployment_replicas
    selector {
      match_labels = {
        app = "gokhan-wt-app"
      }
    }
    strategy {
      rolling_update {
        max_surge       = 1
        max_unavailable = "25%"
      }
      type = "RollingUpdate"
    }
    template {
      metadata {
        labels = {
          app = "gokhan-wt-app"
        }
      }
      spec {
        container {
          name  = "gokhan-wt-app"
          image = var.gokhan_wt_app_image
          resources {
            requests = {
              memory = "1Gi"
              cpu    = "0.5"
            }
            limits = {
              memory = "2Gi"
              cpu    = "1"
            }
          }
          image_pull_policy        = "Always"
        }
        dns_policy                       = "ClusterFirst"
        restart_policy                   = "Always"
        termination_grace_period_seconds = 30
      }
    }
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "gokhan_wt_app_hpa" {
  metadata {
    name = "gokhan-wt-app-hpa"
    labels = {
      app = "gokhan-wt-app"
    }
  }
  spec {
    min_replicas                      = var.gokhan_wt_app_hpa_min_replicas
    max_replicas                      = var.gokhan_wt_app_hpa_max_replicas
    target_cpu_utilization_percentage = var.gokhan_wt_app_hpa_cpu
    scale_target_ref {
      kind        = "Deployment"
      name        = "gokhan-wt-app-deployment"
      api_version = "apps/v1beta1"
    }
  }
}

resource "kubernetes_service" "gokhan_wt_app_service" {
  metadata {
    name = "gokhan-wt-app-service"
    labels = {
      app = "gokhan-wt-app"
    }
  }
  spec {
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30088
      protocol    = "TCP"
    }
    type = "NodePort"
    selector = {
      app = "gokhan-wt-app"
    }
  }
}
