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

RUN apt-get install -y ruby git direnv unzip

RUN addgroup --gid $GROUP_ID ${USER} \
  && useradd --groups sudo --no-create-home --shell /bin/bash ${USER} --uid ${USER_ID} --gid ${GROUP_ID} \
  && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
  && chmod 0440 /etc/sudoers.d/${USER}
RUN mkdir -p /home/${USER} && chown -R ${USER}:${USER} /home/${USER}

USER ${USER}

SHELL ["bash", "-c"]

RUN curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

WORKDIR /home/${USER}

ENV PATH=${PATH}:/home/linuxbrew/.linuxbrew/bin

RUN sudo chown -R ${USER}:${USER} /usr/local

RUN curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /usr/local/bin

RUN echo 'eval "$(oh-my-posh init bash)"' >> .bashrc

RUN curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | bash

ENV BASH_ENV=/home/${USER}/.bashrc

ARG PACKAGES

RUN if [ -n "$PACKAGES" ]; then \
  brew install ${PACKAGES}; exit 0;\
  fi

ENTRYPOINT [ "code", "-v", "tunnel" ]
