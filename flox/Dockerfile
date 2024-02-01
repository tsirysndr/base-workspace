FROM ubuntu

RUN apt-get update \
  && apt-get install -y \
  curl \
  gpg \
  wget

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
RUN echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
RUN rm -f packages.microsoft.gpg

RUN  apt-get install -y apt-transport-https \
  && apt-get update \
  && apt-get install -y \
  code sudo direnv unzip git

RUN curl --proto =https --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --extra-conf "sandbox = false" --init none --no-confirm
ENV PATH=${PATH}:/nix/var/nix/profiles/default/bin
RUN sed -i 's/auto-allocate-uids = true/auto-allocate-uids = false/g' /etc/nix/nix.conf

ARG USER=coder
ARG USER_ID=30033
ARG GROUP_ID=30033

RUN addgroup --gid $GROUP_ID ${USER} \
  && useradd --groups sudo --no-create-home --shell /bin/bash ${USER} --uid ${USER_ID} --gid ${GROUP_ID} \
  && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
  && chmod 0440 /etc/sudoers.d/${USER}

RUN mkdir -p /home/${USER} && chown -R ${USER}:${USER} /home/${USER}

USER ${USER}

ENV PATH=${PATH}:/home/${USER}/.nix-profile/bin

RUN sudo chown -R ${USER}:${USER} /nix/store /nix/var

SHELL ["bash", "-c"]

RUN echo 'extra-trusted-substituters = https://cache.floxdev.com' | sudo tee -a /etc/nix/nix.conf \
  && echo 'extra-trusted-public-keys = flox-store-public-0:8c/B+kjIaQ+BloCmNkRUKwaVPFWkriSAd0JJvuDu4F0=' | sudo tee -a /etc/nix/nix.conf

RUN nix profile install --impure --experimental-features "nix-command flakes auto-allocate-uids" --accept-flake-config github:flox/floxpkgs#flox.fromCatalog

WORKDIR /home/${USER}

RUN sudo chown -R ${USER}:${USER} /usr/local

RUN curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /usr/local/bin

RUN echo 'eval "$(oh-my-posh init bash)"' >> .bashrc

RUN curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | bash

ENV BASH_ENV=/home/${USER}/.bashrc

ENTRYPOINT [ "code", "-v", "tunnel" ]
