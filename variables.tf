variable "packages" {
  type = list(string)
  description = "Packages to install"
  default = []
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
  default = "./pkgx"
}

variable "volumes" {
  type = map(string)
  description = "Volumes to mount"
  default = {
    base-workspace = "/home/coder"
  }
}
