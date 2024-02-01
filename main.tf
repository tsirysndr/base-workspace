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
    build_args = {
      USER = var.user
      PACKAGES = join(" ", var.packages)
    }
  }
}

resource "docker_container" "base" {
  image = docker_image.base.image_id
  name  = var.workspace_name
  
  dynamic "volumes" {
    for_each = var.volumes
    content {
      volume_name    = volumes.key
      container_path = volumes.value
      read_only      = false
    }
  }
}
