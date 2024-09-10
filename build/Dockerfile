FROM ubuntu:24.04

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
  code 

RUN curl https://pkgx.sh | sh

ARG USER=coder
ARG USER_ID=30033
ARG GROUP_ID=30033

RUN apt-get install -y sudo unzip git locales

RUN locale-gen en_US.UTF-8

RUN addgroup --gid $GROUP_ID ${USER} \
  && useradd --groups sudo --no-create-home --shell /bin/bash ${USER} --uid ${USER_ID} --gid ${GROUP_ID} \
  && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
  && chmod 0440 /etc/sudoers.d/${USER}

RUN mkdir -p /home/${USER} && chown -R ${USER}:${USER} /home/${USER}

ENV DOCKER_TLS_CERTDIR=/certs
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client
COPY --from=docker:27-dind /usr/local/bin/ /usr/local/bin/
COPY --from=docker:27-dind /usr/local/libexec/ /usr/local/libexec/
VOLUME /var/lib/docker

USER ${USER}

WORKDIR /home/${USER}

RUN echo 'eval "$(pkgx --shellcode)"' >> .bashrc

ENV BASH_ENV=/home/${USER}/.bashrc

SHELL ["bash", "-c"]

RUN pkgx --version

RUN sudo chown -R ${USER}:${USER} /usr/local

RUN curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /usr/local/bin

RUN echo 'eval "$(oh-my-posh init bash)"' >> .bashrc

RUN curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | bash

RUN curl -fsSL https://github.com/cashapp/hermit/releases/download/stable/install.sh | /bin/bash

ENV PATH=${PATH}:/home/${USER}/bin

ARG PACKAGES

RUN if [ -n "$PACKAGES" ]; then \
  pkgx install ${PACKAGES};\
  fi

COPY entry.sh /usr/local/bin/entry.sh

RUN sudo chmod a+x /usr/local/bin/entry.sh

ENTRYPOINT [ "entry.sh" ]
