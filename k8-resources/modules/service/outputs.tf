output "mysql_service" {
  value = kubernetes_service_v1.mysql_service
}

output "todo_service" {
  value = kubernetes_service_v1.todo_service
}