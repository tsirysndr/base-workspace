# Base Workspace 🧑‍💻

This is my base workspace for all my projects. It contains a portable [docker](https://docker.com) environment with [vscode tunnels](https://code.visualstudio.com/docs/remote/tunnels) already configured, provisioned using [terraform](https://terraform.io).

![Made with VHS](https://vhs.charm.sh/vhs-mfuUe2nAemQJ5Rl5rfinr.gif)

## 🚀 Usage

```bash
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
| workspace_name | Name of the workspace | `string`       | `base-workspace` |
| user           | User to create        | `string`       | `coder`         |
| context        | Context to use        | `string`       | `./pkgx`         |
| volumes        | Volumes to mount      | `map(string)` | `{ base-workspace = "/home/coder" }`             |


## 📝 License

This project is licensed under the [MIT License](LICENSE).

