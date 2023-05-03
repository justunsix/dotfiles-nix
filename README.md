# dotfiles-nix

dotfiles set up by nix

## Usage

```sh

# Install git and nix for your *nix operating system

sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
curl -L https://nixos.org/nix/install | sh

# Set up home-manager
mkdir -p ~/.config
# Clone repository into `~/.config/home-manager`
cd ~/.config
# Assume git is install on your system
git clone https://github.com/justunsix/dotfiles-nix.git ~/.config/home-manager
cd ~/.config/home-manager
# Install the configuration and programs from flake.nix
nix run . switch
# Apply home-manager configuration and make backups of old files
home-manager switch -b bak
```

### Update

```sh
nix flake update
home-manager switch -b bak
# or use topgrade installed by home-manager
topgrade -y
```

## Acknowledgements

- [Tidying you home with nix](https://juliu.is/tidying-your-home-with-nix/)
  - [Arkham/dotfiles.nix on GitHub](https://github.com/Arkham/dotfiles.nix)
- [Home-Manager Appendix A Configuration options](https://nix-community.github.io/home-manager/options.html)
