{ pkgs, ... }: {
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}