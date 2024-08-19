# Base Workspace 🧑‍💻

[![ci](https://github.com/tsirysndr/base-workspace/actions/workflows/ci.yml/badge.svg)](https://github.com/tsirysndr/base-workspace/actions/workflows/ci.yml)

This is my base workspace for all my projects. It contains a portable [docker](https://docker.com) environment with [vscode tunnels](https://code.visualstudio.com/docs/remote/tunnels) already configured, provisioned using [terraform](https://terraform.io).

![Made with VHS](https://vhs.charm.sh/vhs-mfuUe2nAemQJ5Rl5rfinr.gif)

## 🚀 Quickstart

Create a new workspace using the [pocketenv](https://github.com/pocketenv-io/pocketenv) command line tool:

```sh
pocketenv init -t tsirysndr/base-workspace
pocketenv up
```

Or using [terraform](https://terraform.io):

```sh
git clone https://github.com/tsirysndr/base-workspace.git
cd base-workspace
terraform init
terraform apply
```

A new Docker container will be created with the name `base-workspace` with [pkgx](https://pkgx.sh), [oh-my-posh](https://ohmyposh.dev/), [atuin](https://atuin.sh/) and vscode server installed.

To connect to the environment, run:

```bash
docker logs base-workspace
```

and follow the vscode tunnel instructions.

You can also enter to the environment using:

```bash
docker exec -it base-workspace bash
```

## ✨ Bonus

[oh-my-posh](https://ohmyposh.dev/) and [atuin](https://atuin.sh/) are already configured in the environment.

## 🐚 Environments

| Name   | Description                                          |
|--------|------------------------------------------------------|
| devbox  | [devbox](https://github.com/jetpack-io/devbox) environment with vscode tunnels configured. |
| devenv  | [devenv](https://devenv.sh/) environment with vscode tunnels configured. |
| flox    | [flox](https://flox.dev/) environment with vscode tunnels configured.   |
| hombrew | [homebrew](https://brew.sh/) environment with vscode tunnels configured.   |
| nix     | [nix](https://nixos.org/) environment with vscode tunnels configured.    |
| pkgx    | [pkgx](https://pkgx.sh/) environment with vscode tunnels configured.   |
| default | base environment with vscode tunnels configured.   |

## ⚙️ Inputs

| Name           | Description           |  Type           | Default         |
|----------------|-----------------------|----------------|------------------|
| context        | Docker build context to use | `string`       | `null`         |
| hostname       | Hostname to use       | `string`       |   `null`               |
| image          | Docker image to use, required if context is not set   | `string`       | `ghcr.io/pocketenv-io/pkgx:main` |
| packages       | Packages to install   | `list(string)` | `[]`             |
| user           | User to create        | `string`       | `coder`         |
| volumes        | Volumes to mount      | `map(string)` | `{ base-workspace = "/home/coder" }`             |
| workspace_name | Name of the workspace | `string`       | `base-workspace` |

## 📦 Outputs

| Name           | Description           |  Type          |
|----------------|-----------------------|----------------|
| container_id   | Docker container id   | `string`       |


## 📚 Examples

devbox.tfvars

```hcl
workspace_name = "devbox-workspace"

user = "coder"

context = "./devbox"

volumes = {
  devbox-workspace = "/home/coder"
  devbox-nix = "/nix"
}
```

devenv.tfvars

```hcl
workspace_name = "devenv-workspace"

user = "coder"

context = "./devenv"

volumes = {
  devenv-workspace = "/home/coder"
  devenv-nix = "/nix"
}
```

flox.tfvars 

```hcl
workspace_name = "flox-workspace"

user = "coder"

context = "./flox"

volumes = {
  flox-workspace = "/home/coder"
  flox-nix = "/nix"
}
```

homebrew.tfvars

```hcl
workspace_name = "brew-workspace"

packages = [
  "jq",
  "gh"
]

user = "coder"

context = "./homebrew"

volumes = {
  brew-workspace = "/home/coder"
  linuxbrew = "/home/linuxbrew/.linuxbrew"
}
```

pkgx.tfvars

```hcl
workspace_name = "pkgx-workspace"

packages = [
  "jq",
  "gh"
]

user = "coder"

context = "./pkgx"

volumes = {
  pkgx-workspace = "/home/coder"
}
```

## 📝 License

This project is licensed under the [MIT License](LICENSE).

