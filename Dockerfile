FROM debian:10
LABEL maintainer="srikarvgudipati@gmail.com"

ARG DEBIAN_FRONTEND=noninteractive
ENV PATH=/root/.volta/bin:$PATH
ENV TERM=xterm-256color

WORKDIR /root

# Install
RUN \
  apt-get -qq -y update && \
  apt-get install -qq -y --no-install-recommends \
  bash \
  ca-certificates \
  curl \
  fd-find \
  gcc \
  git \
  less \
  locales \
  python3-dev \
  python3-pip \
  python3-setuptools \
  ripgrep \
  rsync \
  sudo \
  tldr \
  tree \
  vim \
  zsh

# Locale
RUN \
  echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
  echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
  locale-gen en_US.UTF-8

RUN ln -s $(which fdfind) /usr/bin/fd

RUN git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf

RUN pip3 install thefuck

RUN curl https://get.volta.sh | bash

RUN volta install node

COPY . /root/.Dotfiles

RUN /root/.Dotfiles/setup.sh -f

RUN /root/.fzf/install --all --no-bash

# Clean Up
RUN apt-get autoclean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Command to run
CMD [ "/bin/zsh" ]
