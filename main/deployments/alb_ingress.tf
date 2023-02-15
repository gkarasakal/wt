resource "aws_security_group" "alb-ingress-security-group" {
  name        = "Gokhan ALB Ingress Security Group"
  description = "Allow inbound traffic to Gokhan WT Application LoadBalancer"
  vpc_id      = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.web_traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Gokhan ALB Ingress Security Group"
    Project     = "WT"
    Environment = local.env
  }
}

resource "kubernetes_ingress_v1" "alb_ingress" {
  metadata {
    name = "gokhan-wt-alb-ingress"
    annotations = {
    "kubernetes.io/ingress.class" = "alb",
    "alb.ingress.kubernetes.io/scheme" = "internet-facing",
    "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\": 80}]",
    "alb.ingress.kubernetes.io/backend-protocol" = "HTTP",
    "alb.ingress.kubernetes.io/healthcheck-protocol" = "HTTP",
    "alb.ingress.kubernetes.io/healthcheck-path" = "/healthz",
    "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = var.alb_healthcheck_interval,
    "alb.ingress.kubernetes.io/healthcheck-port" = "traffic-port",
    "alb.ingress.kubernetes.io/success-codes" = "200,404,301",
    "alb.ingress.kubernetes.io/security-groups" = aws_security_group.alb-ingress-security-group.id,
    "alb.ingress.kubernetes.io/group.name" = "gokhan-wt-${local.env}-ingress-group"
    }
  }

  spec {
    rule {
      http {
        path {
          backend {
            service {
              name = "gokhan-wt-app-service"
              port {
                number = 8080
              }
            }
          }
          path = "/*"
        }
      }
    }
  }
}
