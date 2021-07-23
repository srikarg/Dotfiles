FROM ubuntu:focal
LABEL maintainer="srikarvgudipati@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive
ENV PATH=/root/.volta/bin:$PATH
ENV TERM=xterm-256color

WORKDIR /root

# Install
RUN \
  apt-get -qq -y update && \
  apt-get install -qq -y --no-install-recommends \
  ca-certificates \
  curl \
  git \
  rsync \
  sudo \
  zsh \
  python3-dev \
  python3-pip \
  python3-setuptools

RUN curl --create-dirs -o /usr/share/zsh-antigen/antigen.zsh -sL git.io/antigen

RUN pip3 install thefuck

RUN curl https://get.volta.sh | bash

RUN volta install node

RUN mkdir -p /root/.zsh

RUN git clone https://github.com/sindresorhus/pure.git /root/.zsh/pure

COPY . /root/.Dotfiles

RUN /root/.Dotfiles/setup.sh -f

# Clean Up
RUN apt-get autoclean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Command to run
CMD [ "/bin/zsh" ]
