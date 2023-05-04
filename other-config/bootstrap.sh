# Install git and nix for your *nix operating system
# Install nix
sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Enable nix flakes
mkdir -p ~/.config/nix
cat <<EOF >> ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

# Set up home-manager
mkdir -p ~/.config
mkdir -p ~/Code
cd ~/Code
# Assume git is install on your system
git clone https://github.com/justunsix/dotfiles-nix.git
cd ~/.config
ln -s -f "$HOME/Code/dotfiles-nix" home-manager
cd home-manager

# Install the configuration and programs from flake.nix
nix run . switch
# Apply home-manager configuration and make backups of old files
home-manager switch -b bak

cd other-config
./link-dotfiles.sh
