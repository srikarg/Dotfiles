FROM debian
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
  cmake \
  curl \
  fd-find \
  gcc \
  gettext \
  git \
  less \
  locales \
  make \
  ninja-build \
  pipx \
  python3-dev \
  python3-setuptools \
  ripgrep \
  rsync \
  stow \
  sudo \
  tldr \
  tree \
  unzip \
  vim \
  zsh

# Locale
RUN \
  echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
  echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
  locale-gen en_US.UTF-8

# https://github.com/neovim/neovim/wiki/Building-Neovim#quick-start
RUN git clone https://github.com/neovim/neovim /tmp/neovim

RUN cd /tmp/neovim && git checkout stable && make CMAKE_BUILD_TYPE=Release && make install

RUN ln -s $(which fdfind) /usr/bin/fd

RUN git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf

RUN pipx install thefuck

RUN curl https://get.volta.sh | bash

RUN volta install node

COPY . /root/.Dotfiles

RUN cd /root/.Dotfiles && ./setup.sh -f

RUN /root/.fzf/install --all --no-bash

# Clean Up
RUN apt-get autoclean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Command to run
CMD [ "/bin/zsh" ]
