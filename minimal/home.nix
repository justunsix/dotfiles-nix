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
    #     freetube

    # DevOps
    helix
    git
    gfold
    neovim
    pandoc
    ## Nix
    ### Nix LSP
    nil
    ### Nix formatter
    nixpkgs-fmt
    ## Python for scripts
    uv
    ## Required Neovim framework dependencies
    gcc
    xsel
    fzf
    ## Optional Neovim framework dependencies
    ripgrep
    fd
    ### For integration with Neovim language support
    tree-sitter
    ### NodeJS LTS as of 2025-03
    nodejs_22

    # Shell
    nushell
    atuin
    carapace
    starship
    zoxide
    broot
    yazi
    ## lg, make are optional Neovim framework dependency
    lazygit
    gnumake
    # Fonts
    ## Per NixOS PR 362769
    nerd-fonts.jetbrains-mono

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
    ".config/helix/config.toml".source = ~/Code/dotfiles/.config/helix/config.toml;
    ".config/helix/languages.toml".source = ~/Code/dotfiles/.config/helix/languages.toml;
    #    ".config/nushell/env.nu".source = ~/Code/dotfiles/.config/nushell/env.nu;
    #    ".config/nushell/config.nu".source =
    #      ~/Code/dotfiles/.config/nushell/config.nu;
    #    ".config/nushell/config-nix.nu".source =
    #      ~/Code/dotfiles/.config/nushell/config-nix.nu;
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
    "$HOME/.local/bin"
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
      gg = "lazygit";
      ggs = "git status";
      ggd = "git diff";
      ggf = "git pull";
      gglrf = "topgrade --only git_repos";
      gglrs = "bash -c 'gfold ~/Code -c always -d classic'";
      ff = "^$env.EDITOR (fd --hidden --exclude .git | fzf)";
      ggsc = "jgc";
    };
    # Extra functions
    extraConfig = ''
          # Get Makefile tasks in directory, pick and run task
          def fm [] {
              # Check if fzf is installed
              if (which fzf | is-empty) {
                  print 'fzf is not installed. Please install it to use this script.'
                  return
              }

              # Check if Makefile exists
              if not (['Makefile'] | path exists | get 0) {
                  print 'No Makefile found in the current directory.'
                  return
              }

              # Extract make targets with `##` help comments (like `target: ## description`)
              let targets = open Makefile
                  | lines
                  | where ($it =~ '^[a-zA-Z0-9][^:]*:.*##')
                  | each {|line| $line | split row ':' | get 0 | str trim }
                  | uniq

              # Pass targets to fzf for selection
              let selected_target = ($targets | to text | fzf --height 40% --reverse --inline-info --prompt 'Select a target: ')

              # Run make with the selected target
              if not ($selected_target | is-empty ) {
                  print $'Executing make ($selected_target)...'
                  ^make $selected_target
              } else {
                  print 'No target selected.'
              }

          }
          # Stages, commits, and pushes Git changes with a provided commit message or autocommit message if no message is provided
          def jgc [
            message = 'auto commit': string   # Commit message
            ] {
              # Commit with the provided message
              git commit -am $message

              # Push to the current branch
              git push
          }

          # Search for string in files and open in editor
          def fgrep [
            stringToSearch = 'todo': string # Search term
            --ext: string = "*", # Search on files with these extensions
            --vim, # If it should open in neovim
          ] {    

          # Search case insensitive with rg including hidden files except .git dir,
          # and including extension in glob to search, then
          # filter file list with fzf and get filename with cut
          let $result = rg -i $stringToSearch --hidden -g'!.git' -g $"*.($ext)" | fzf | cut -d':' -f 1
          if ($vim) {
              nvim $result
          } else {
              ^$env.EDITOR $result
          }
      }'';
  };

  # Globally enable shell integration for all supported shells
  home.shell.enableShellIntegration = true;

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

  # Yazi
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    shellWrapperName = "y";
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
        repos = [ "~/Code/*" ];
      };
    };
  };

  # Temporarily disable version check differences
  home.enableNixpkgsReleaseCheck = false;

}
