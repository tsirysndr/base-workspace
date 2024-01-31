terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "flox" {
  name = "flox-workspace"
  build {
    context = "."
  }
}

resource "docker_container" "flox" {
  image = docker_image.flox.image_id
  name  = "flox-workspace"

  volumes {
    volume_name    = "flox-workspace"
    container_path = "/home/coder"
    read_only      = false
  }

  volumes {
    volume_name = "flox-nix"
    container_path = "/nix"
    read_only = false
  }
}
