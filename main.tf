terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "default" {
  name = var.image
   count = var.context != null ? 0 : 1
}

resource "docker_image" "base" {
  name = var.workspace_name
  count = var.context != null ? 1 : 0

  build {
    context = var.context
    build_args = {
      USER = var.user
      PACKAGES = join(" ", var.packages)
    }
  }
}

resource "docker_container" "base" {
  image = var.context != null ? docker_image.base[0].image_id : docker_image.default[0].image_id
  name  = var.workspace_name
  hostname = var.hostname
  
  dynamic "volumes" {
    for_each = var.volumes
    content {
      volume_name    = volumes.key
      container_path = volumes.value
      read_only      = false
    }
  }
}
