terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "pkgx" {
  name = "base-workspace"
  build {
    context = "."
  }
}

resource "docker_container" "pkgx" {
  image = docker_image.pkgx.image_id
  name  = "pkgx-workspace"

  volumes {
    volume_name    = "pkgx-workspace"
    container_path = "/home/coder"
    read_only      = false
  }
}
