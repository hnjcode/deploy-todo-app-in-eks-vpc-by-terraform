resource "kubernetes_deployment_v1" "mysql" {
  metadata {
    name      = "mysqldb"
    namespace = var.namespace
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mysqldb"
      }
    }
    template {
      metadata {
        labels = {
          app = "mysqldb"
        }
      }
      spec {
        container {
          name  = "mysqldb"
          image = "mysql:8"
          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = "1111"
          }
          env {
            name  = "MYSQL_DATABASE"
            value = "todo_db"
          }
          volume_mount {
            name       = "mysql-data"
            mount_path = "/var/lib/mysql"
          }
        }
        volume {
          name = "mysql-data"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_deployment_v1" "todo_api" {
  metadata {
    name      = "todo-api"
    namespace = var.namespace
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "todo-api"
      }
    }
    template {
      metadata {
        labels = {
          app = "todo-api"
        }
      }
      spec {
        container {
          image = "hnjaman/todo-service:latest"
          name  = "todo-api"
          env {
            name  = "MYSQL_HOST"
            value = "mysqldb"
          }
          env {
            name  = "MYSQL_USER"
            value = "root"
          }
          env {
            name  = "MYSQL_PASSWORD"
            value = "1111"
          }
          env {
            name  = "MYSQL_PORT"
            value = "3306"
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }

  depends_on = [
    var.mysql_service
  ]
}


resource "kubernetes_deployment_v1" "todo_ui" {
  metadata {
    name      = "todo-ui"
    namespace = var.namespace
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "todo-ui"
      }
    }
    template {
      metadata {
        labels = {
          app = "todo-ui"
        }
      }
      spec {
        container {
          image = "hnjaman/todo-service-ui:latest"
          name  = "todo-ui"
          port {
            container_port = 80
          }
        }
      }
    }
  }

  depends_on = [
    var.todo_service
  ]
}