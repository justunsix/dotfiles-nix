{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "justin";
  home.homeDirectory = "/home/justin";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # Files and System
    # pkgs.peazip
    p7zip
    topgrade

    # Web
    freetube

    # DevOps
    helix
    git
    gfold
    neovim
    ## Required Neovim framework dependencies
    gcc
    xsel
    ## Optional Neovim framework dependencies
    ripgrep
    fd

    # Shell
    nushell
    atuin
    carapace
    starship
    zoxide
    broot
    ## lg, make are optional Neovim framework dependency
    lazygit
    gnumake

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Allow fontconfig to discover fonts and configurations installed through home.packages and nix-env
  # per https://github.com/nix-community/home-manager/issues/605
  fonts.fontconfig = {
    enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/justin/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Add directories to your PATH
  # but bug for now https://github.com/nix-community/home-manager/issues/3417
  home.sessionPath = [
    "$HOME/usr/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  ##########################
  # Programs Configuration #
  ##########################

  # Let home-manager manage shells
  programs.bash = {
    enable = true;
  };

  # Let home-manager manage shells
  programs.nushell = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
      jgt= "bash -c 'gfold ~/Code -c always -d classic'";
    };
  };

  # Atuin
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
  
  # Broot
  programs.broot = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  # Carapace
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Starship
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      # format = "$all";
      shell = {
        format = "[$indicator ](bold cyan) ";
        disabled = false;
      };
    };
  };

  # Zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  # topgrade
  programs.topgrade = {
    enable = true;
    settings = {
      # Include misc to avoid error
      misc = { };
      git = {
        max_concurrency = 5;
        repos = ["~/Code/*"];
      };
    };
  };

  # Temporarily disable version check differences
  home.enableNixpkgsReleaseCheck = false;

}
