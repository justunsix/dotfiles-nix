# dotfiles-nix

dotfiles set up by nix

## Usage

```sh

# Install git and nix for your *nix operating system

sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
curl -L https://nixos.org/nix/install | sh

# Enable nix flakes
mkdir -p ~/.config/nix
cat <<EOF >> ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

# Set up home-manager
mkdir -p ~/.config
# or my preferred location `~/Code/dotfiles-nix` and then symlink
# Assume git is install on your system
git clone https://github.com/justunsix/dotfiles-nix.git ~/Code/dotfiles-nix
ln -s ~/Code/dotfiles-nix ~/.config/home-manager
cd ~/.config/home-manager
# Install the configuration and programs from flake.nix
nix run . switch
# Apply home-manager configuration and make backups of old files
home-manager switch -b bak
```

### Update

```sh
cd ~/.config/home-manager
nix flake update
home-manager switch -b bak
# or use topgrade installed by home-manager
topgrade -y
```

## Acknowledgements

- [Tidying you home with nix](https://juliu.is/tidying-your-home-with-nix/)
  - [Arkham/dotfiles.nix on GitHub](https://github.com/Arkham/dotfiles.nix)
- [Home-Manager Appendix A Configuration options](https://nix-community.github.io/home-manager/options.html)
