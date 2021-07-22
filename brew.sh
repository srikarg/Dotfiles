#!/usr/bin/env bash

# Install Homebrew if it's missing
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew"
  yes '' | /bin/bash -c "$(curl -kfsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

brew bundle install --global

# Remove outdated versions from the cellar.
brew cleanup

# Switch to using brew-installed zsh as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/zsh" /etc/shells; then
  echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells
  chsh -s "${BREW_PREFIX}/bin/zsh"
fi
