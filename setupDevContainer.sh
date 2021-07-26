#!/usr/bin/env bash

DOTFILES_DIR="$HOME/.Dotfiles"

git submodule init && git submodule update

rsync --exclude ".git/" \
  --exclude ".DS_Store" \
  --exclude "setup.sh" \
  --exclude "setupDevContainer.sh" \
  --exclude "brew.sh" \
  --exclude "README.md" \
  --exclude "Dockerfile" \
  -avP --no-perms $DOTFILES_DIR/ $HOME
