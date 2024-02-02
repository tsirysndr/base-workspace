variable "packages" {
  type = list(string)
  description = "Packages to install"
  default = []
}

variable "hostname" {
  type = string
  description = "Hostname of the container"
  default = null
} 

variable "image" {
  type = string
  description = "Image to use, required if context is not set"
  default = "ghcr.io/pocketenv-io/pkgx:main"
}

variable "workspace_name" {
  type = string
  description = "Name of the workspace"
  default = "base-workspace"
}

variable "user" {
  type = string
  description = "User to create"
  default = "coder"
}

variable "context" {
  type = string
  description = "Context to use"
  default = null
}

variable "volumes" {
  type = map(string)
  description = "Volumes to mount"
  default = {
    base-workspace = "/home/coder"
  }
}
