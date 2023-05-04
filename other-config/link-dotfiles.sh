#!/usr/bin/env bash

# Location of dotfiles folder to symlink to
DOTFILES_DIR="$HOME/Code/dotfiles"
DOTFILES_OVERLAY_DIR="$HOME/Code/dotfiles-overlay"

# Symlink specific files 
mkdir -p $HOME/.config/emacs/setup
# Symbolic link emacs configuration files to ~/.config/emacs 
# -t : target directory for files in stow package
# -d : directory containing stow package (source files)
# -S emacs : stow package that is source of files (folder in dotfiles folder)
# -vv verbose output
stow -vv -t "$HOME/.config/emacs" -d "$DOTFILES_DIR/.config" -S emacs
ln -s -f "$DOTFILES_OVERLAY_DIR/env/.config/emacs/setup/env.el" "$HOME/.config/emacs/setup/env.el"