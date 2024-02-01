terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "base" {
  name = var.workspace_name
  build {
    context = var.context
  }
}

resource "docker_container" "base" {
  image = docker_image.base.image_id
  name  = var.workspace_name

  for_each = var.volumes
  volumes {
    volume_name    = each.key
    container_path = each.value
    read_only      = false
  }
}
