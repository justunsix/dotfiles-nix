{ pkgs, ... }: {
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # System and Files
    git
    bashInteractive # unsure why required?
    topgrade
    curl
    htop
    keychain
    stow
    ranger
    # Fonts
    source-code-pro
    jetbrains-mono
    # DevOps
    emacs
    ## Emacs package requirements
    nodejs
    pandoc
    ripgrep
    ## Spelling
    hunspell
    hunspellDicts.en_CA
    # Browser
    firefox
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