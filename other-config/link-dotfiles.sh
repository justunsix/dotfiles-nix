#!/usr/bin/env bash

# Location of dotfiles folder to symlink to
DOTFILES_DIR="$HOME/Code/dotfiles"

# Symlink specific files with stow
stow --target=$HOME -d $DOTFILES_DIR/.bash_profile
