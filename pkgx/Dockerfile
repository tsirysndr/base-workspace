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
  code 

RUN curl https://pkgx.sh | sh

ARG USER=coder

RUN apt-get install -y sudo

RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
  && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
  && chmod 0440 /etc/sudoers.d/${USER}

RUN mkdir -p /home/${USER} && chown -R ${USER}:${USER} /home/${USER}

USER ${USER}

COPY .bashrc /home/${USER}/.bashrc

ENV BASH_ENV=/home/${USER}/.bashrc

SHELL ["bash", "-c"]

RUN pkgx --version

WORKDIR /home/${USER}

ENTRYPOINT [ "code", "-v", "tunnel" ]
