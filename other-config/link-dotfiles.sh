#!/usr/bin/env bash

# Location of dotfiles folder to symlink to
DOTFILES_DIR="$HOME/Code/dotfiles"

# Symlink specific files 
ln -s -f "$DOTFILES_DIR/.config/emacs" "$HOME/.config/emacs"
ln -s -f "$DOTFILES_DIR/.bashrc" "$HOME/.config/.bashrc"

