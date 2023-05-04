# Other Configuration

This folder contains steps to link traditional configuration files not managed by nix with the nix configuration files in this repository.

It uses a dotfiles repository like [my dotfiles](https://github.com/justunsix/dotfiles) and symlinks them to the user's home directory using [GNU Stow](https://www.gnu.org/software/stow/).

## Purpose of this Folder

- I am exploring nix and my dotfiles and programs are managed by dotfiles and [Ansible playbooks](https://github.com/justunsix/dotfiles-playbook) for system configuration.
- Information and scripts in this folder allow combining dotfiles configuration using nix and those other methods.

## Bootstrap.sh

If behind a proxy and trying to install nix, try these instructions

git config --global https.proxy https://proxy:port
git config --global http.proxy http://proxy:port

export HTTP_PROXY=proxy:port
export HTTPS_PROXY=proxy:port
export http_proxy=proxy:port
export https_proxy=proxy:port
export ftp_proxy=proxy:port
export CURL_NIX_FLAGS=proxy:port
