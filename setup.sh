#!/usr/bin/env bash

DOTFILES_DIR="$HOME/.Dotfiles"
DOTFILES_BACKUP_DIR="$HOME/.Dotfiles_Old"
SYSTEM_TYPE=$(uname -s)

git submodule init && git submodule update

function doIt() {
  printf "Installing Dotfiles to $DOTFILES_DIR and backing up old Dotfiles to $DOTFILES_BACKUP_DIR...\n"
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude "setup.sh" \
    --exclude "brew.sh" \
    --exclude "README.md" \
    --exclude "Dockerfile" \
    -avP --no-perms --backup-dir=$DOTFILES_BACKUP_DIR $DOTFILES_DIR/ $HOME
  exec zsh -l
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi
unset doIt

# Only set up iTerm2 on MacOS
if [ "$SYSTEM_TYPE" = "Darwin" ]; then
  printf "Installing brew packages...\n"
  . $DOTFILES_DIR/brew.sh

  if [ -d "$HOME/.iterm2" ]; then
    printf "Setting up iTerm2 preferences folder...\n"
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.iterm2"
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
  fi
fi
