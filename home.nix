{ config, pkgs, ... }:

{
  home.stateVersion = "23.11";
  home.username = "alexg";
  home.homeDirectory = "/home/alexg";

  home.packages = with pkgs; [ 
    beekeeper-studio
    fd
    ripgrep
    vscode-fhs
    transmission-gtk
    vlc
    alacritty
    tmux
  ];

  home.file =
  let
    link = config.lib.file.mkOutOfStoreSymlink;
    config-root = "/home/alexg/Code/nix";
  in {
    ".p10k.zsh".source = link "${config-root}/config/p10k.zsh";
    ".config/alacritty/alacritty.toml".source = link "${config-root}/config/alacritty.toml";
    ".config/tmux/tmux.conf".source = link "${config-root}/config/tmux.conf";
  };
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Alex Gravem";
    userEmail = "recoeur@proton.me";
    extraConfig = { pull = { rebase = true; }; };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    historySubstringSearch.enable = true;
    initExtra = ''
    source ~/.p10k.zsh
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    shellAliases = {
      ll = "ls -l";
      rebuild = "sudo nixos-rebuild switch --flake";
    };
  };
}

