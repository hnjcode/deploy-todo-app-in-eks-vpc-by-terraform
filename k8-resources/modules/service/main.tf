resource "kubernetes_service_v1" "mysql_service" {
  metadata {
    name      = "mysqldb"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "mysqldb"
    }
    port {
      port        = 3306
      target_port = 3306
    }
  }
}


resource "kubernetes_service_v1" "todo_service" {
  metadata {
    name      = "todo-service"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "todo-api"
    }
    port {
      port        = 8080
      target_port = 8080
    }
  }
}


resource "kubernetes_service_v1" "todo_service_ui" {
  metadata {
    name      = "todo-service-ui"
    namespace = var.namespace
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb" # To create Network Load Balancer
    }
  }
  spec {
    selector = {
      app = "todo-ui"
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}