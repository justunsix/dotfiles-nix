{ pkgs, ... }: {
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = [
    # System and Files
    pkgs.git
    pkgs.bashInteractive # unsure why required?
    pkgs.topgrade
    pkgs.curl
    pkgs.htop
    pkgs.keychain
    pkgs.stow
    pkgs.ranger
    # Fonts
    pkgs.source-code-pro
    pkgs.jetbrains-mono
    # DevOps
    pkgs.emacs
    ## Emacs package requirements
    pkgs.nodejs
    pkgs.pandoc
    pkgs.ripgrep
    ## Spelling
    pkgs.hunspell
    pkgs.hunspellDicts.en_CA
    # Browser
    pkgs.firefox
  ];

  # Pick up fonts 
  fonts.fontconfig = {
   enable = true;
  };


  programs.bash = {    
    enable = true;    
    initExtra = builtins.readFile ./.bashrc;
  };

  programs.fzf = {   
     enable = true;
     # enableBashIntegration = true;
     enableFishIntegration = true;
  };  
 
  # zoxide
  programs.zoxide = {
    enable = true;
    # enableBashIntegration = true;
    enableFishIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Fish shell
  programs.fish = {
    enable = true;
    shellAliases = {
      "gits"="git status";
      "jgc"="jt-gc.sh";
      "jgs"="jt-gs.sh";
      "jgt"="jt-gt.sh";
    };
  };

}