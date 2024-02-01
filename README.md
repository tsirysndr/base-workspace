# Base Workspace 🧑‍💻

This is my base workspace for all my projects. It contains a portable [docker](https://docker.com) environment with [vscode tunnels](https://code.visualstudio.com/docs/remote/tunnels) already configured, provisioned using [terraform](https://terraform.io).

## 🚀 Usage

```bash
terraform init
terraform apply
```

## ✨ Bonus

[oh-my-posh](https://ohmyposh.dev/) and [atuin](https://atuin.sh/) are already configured in the environment.

## 🐚 Environments

| Name   | Description                                          |
|--------|------------------------------------------------------|
| devbox  | A [devbox](https://github.com/jetpack-io/devbox) environment with vscode tunnels configured. |
| devenv  | A [devenv](https://devenv.sh/) environment with vscode tunnels configured. |
| flox    | A [flox](https://flox.dev/) environment with vscode tunnels configured.   |
| hombrew | A [homebrew](https://brew.sh/) environment with vscode tunnels configured.   |
| nix     | A [nix](https://nixos.org/) environment with vscode tunnels configured.    |
| pkgx    | A [pkgx](https://pkgx.sh/) environment with vscode tunnels configured.   |
| default | A base environment with vscode tunnels configured.   |


## 📝 License

This project is licensed under the [MIT License](LICENSE).

