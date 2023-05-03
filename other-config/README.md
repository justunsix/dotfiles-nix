# Other Configuration

This folder contains steps to link traditional configuration files not managed by nix with the nix configuration files in this repository.

It uses a dotfiles repository like [my dotfiles](https://github.com/justunsix/dotfiles) and symlinks them to the user's home directory using [GNU Stow](https://www.gnu.org/software/stow/).

## Purpose of this Folder

- I am exploring nix and my dotfiles and programs are managed by dotfiles and [Ansible playbooks](https://github.com/justunsix/dotfiles-playbook) for system configuration.
- Information and scripts in this folder allow combining dotfiles configuration using nix and those other methods.
