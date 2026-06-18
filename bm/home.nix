{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/Code/dotfiles-nix/bm";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    alacritty = "alacritty";
  };
in

{
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "26.05";

  # Pick up fonts
  fonts.fontconfig = {
    enable = true;
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.packages = with pkgs; [
    # System and Files
    git
    topgrade
    curl
    btop
    # Fonts
    jetbrains-mono
    # DevOps
    neovim
    # Browser
    firefox
    # Shell, Terminal
    alacritty
    nushell
  ];
}
