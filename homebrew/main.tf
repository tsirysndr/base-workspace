terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "brew" {
  name = "brew-workspace"
  build {
    context = "."
  }
}

resource "docker_container" "brew" {
  image = docker_image.brew.image_id
  name  = "brew-workspace"

  volumes {
    volume_name    = "brew-workspace"
    container_path = "/home/coder"
    read_only      = false
  }

  volumes {
    volume_name    = "linuxbrew"
    container_path = "/home/linuxbrew/.linuxbrew"
    read_only      = false
  }
}
