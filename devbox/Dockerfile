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
  code sudo

ARG USER=coder
ARG USER_ID=30033
ARG GROUP_ID=30033

RUN addgroup --gid $GROUP_ID ${USER} \
  && useradd --groups sudo --no-create-home --shell /bin/bash ${USER} --uid ${USER_ID} --gid ${GROUP_ID} \
  && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
  && chmod 0440 /etc/sudoers.d/${USER}

RUN mkdir -p /home/${USER} && chown -R ${USER}:${USER} /home/${USER}

USER ${USER}

RUN curl --proto =https --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --extra-conf "sandbox = false" --init none --no-confirm
ENV PATH=${PATH}:/nix/var/nix/profiles/default/bin
RUN sudo sed -i 's/auto-allocate-uids = true/auto-allocate-uids = false/g' /etc/nix/nix.conf

RUN sudo addgroup ${USER} nixbld

ENV FORCE=1
RUN curl -fsSL https://get.jetpack.io/devbox | bash

RUN devbox version

RUN sudo chown -R ${USER}:${USER} /nix/store/.links /nix/var

SHELL ["bash", "-c"]

WORKDIR /home/${USER}

ENTRYPOINT [ "code", "-v", "tunnel" ]
