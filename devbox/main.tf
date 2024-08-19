terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "devbox" {
  name = "devbox-workspace"
  build {
    context = "."
  }
}

resource "docker_container" "devbox" {
  image      = docker_image.devbox.image_id
  name       = "devbox-workspace"
  privileged = true

  volumes {
    volume_name    = "devbox-workspace"
    container_path = "/home/coder"
    read_only      = false
  }

  volumes {
    volume_name    = "devbox-nix"
    container_path = "/nix"
    read_only      = false
  }
}
