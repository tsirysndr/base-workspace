terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "devenv" {
  name = "devenv-workspace"
  build {
    context = "."
  }
}

resource "docker_container" "devenv" {
  image = docker_image.devenv.image_id
  name  = "devenv-workspace"

  volumes {
    volume_name    = "devenv-workspace"
    container_path = "/home/coder"
    read_only      = false
  }

  volumes {
    volume_name = "devenv-nix"
    container_path = "/nix"
    read_only = false
  }
}
