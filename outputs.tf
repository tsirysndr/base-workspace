output "container_id" {
  description = "The ID of the container created"
  value = "${docker_container.base.id}"
}