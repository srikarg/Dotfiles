#!/usr/bin/env bash

dir=~/.Dotfiles
# olddir=~/.Dotfiles_Old

shopt -s extglob
shopt -s dotglob

# echo "Making backup directory $olddir."
# mkdir -p $olddir
# cd $dir

# Backup existing dotfiles in home and then create symbolic link from home directory to this directory
for file in !(.DS_Store|.git|setup.sh|brew.sh|README.md|iterm2_profile); do
    # if [[ -d "$HOME/$file" ]] || [ -f "$HOME/$file" ]; then
    #     echo "Backing up $file to $olddir."
    #     mv "$HOME/$file" $olddir
    # fi
    echo "Creating symbolic link to $file in home directory.\n"
    ln -Ffns "$dir/$file" "$HOME/$file"
done

source "$HOME/.bash_profile"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$dir/iterm2_profile"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
