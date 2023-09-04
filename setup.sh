#!/usr/bin/env bash

DOTFILES_DIR="$HOME/.Dotfiles"
ZSH_CACHE_DIR="$HOME/.cache/zsh"
SYSTEM_TYPE=$(uname -s)

git submodule init && git submodule update --recursive --remote

# Check if GNU Stow is installed
if ! command -v stow &>/dev/null; then
  echo "GNU Stow is not installed. Please install it before running this script."
  exit 1
fi

# Delete all .DS_Store files before proceeding with GNU Stow
find "$DOTFILES_DIR" -name ".DS_Store" -type f -print -delete

ln -s "$DOTFILES_DIR"/custom-nvchad-config "$DOTFILES_DIR"/neovim/.config/nvim/lua/custom

function run() {
  for files in $DOTFILES_DIR/*; do
    if [ -d "${files}" ]; then
      stow -R "$(basename "$files")"
      echo "$(basename "$files") stowed."
    fi
  done
  # Create the ZSH cache directory if it doesn't exist
  mkdir -p "$ZSH_CACHE_DIR"
  # Create the ZSH completions directory for plugins if it doesn't exist
  mkdir -p "$ZSH_CACHE_DIR/completions"
  rm -f "$HOME/.zcompdump"
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
  run
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    run
  fi
fi
unset run

# Only set up iTerm2, Homebrew, and Kubectl Krew on MacOS
if [ "$SYSTEM_TYPE" = "Darwin" ]; then
  printf "Installing brew packages...\n"
  . "$DOTFILES_DIR"/homebrew/brew.sh

  if command -v kubectl krew &>/dev/null; then
    printf "Installing kubectl krew plugins...\n"
    kubectl krew install <kubectl-krew-plugin-manager-list.txt
  fi

  printf "Setting up iTerm2 preferences folder...\n"
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.iterm2"
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
fi

exec zsh -l
