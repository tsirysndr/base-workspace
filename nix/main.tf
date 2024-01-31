terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nix" {
  name = "nix-workspace"
  build {
    context = "."
  }
}

resource "docker_container" "nix" {
  image = docker_image.nix.image_id
  name  = "nix-workspace"

  volumes {
    volume_name    = "nix-workspace"
    container_path = "/home/coder"
    read_only      = false
  }

  volumes {
    volume_name = "nix-store"
    container_path = "/nix"
    read_only = false
  }
}
