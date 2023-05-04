# Install git and nix for your *nix operating system
# Install nix
sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
curl -L https://nixos.org/nix/install | sh

# Set up home-manager
mkdir -p ~/.config
mkdir -p ~/Code
cd ~/Code
# Assume git is install on your system
git clone https://github.com/justunsix/dotfiles-nix.git
cd ~/.config
ln -s -f "~/Code/dotfiles-nix" home-manager
cd home-manager

# Install the configuration and programs from flake.nix
nix run . switch
# Apply home-manager configuration and make backups of old files
home-manager switch -b bak

cd other-config
./link-dotfiles.sh