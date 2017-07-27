#!/bin/bash

dir=~/.Dotfiles
# olddir=~/.Dotfiles_Old

shopt -s extglob

# echo "Making backup directory $olddir."
# mkdir -p $olddir
# cd $dir

# Backup existing dotfiles in home and then create symbolic link from home directory to this directory
for file in !(setup.sh); do
    # if [[ -d "$HOME/.$file" ]] || [ -f "$HOME/.$file" ]; then
    #     echo "Backing up .$file to $olddir."
    #     mv "$HOME/.$file" $olddir
    # fi
    echo "\nCreating symbolic link to $file in home directory.\n"
    ln -Fis "$dir/$file" "$HOME/.$file"
done

source "$HOME/.bash_profile"
