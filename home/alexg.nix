{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
  home.username = "alexg";
  home.homeDirectory = "/home/alexg";

  home.packages = with pkgs; [ 
    alacritty
    beekeeper-studio
    fd
    foliate
    ripgrep
    tmux
    transmission-gtk
    vscode-fhs
  ];

  imports = [ 
    ./programs/hyprland
  ];

  home.file =
  let
    link = config.lib.file.mkOutOfStoreSymlink;
    config-root = "/home/alexg/Code/nix/home/config";
  in {
    ".p10k.zsh".source = link "${config-root}/p10k.zsh";
    ".config/alacritty".source = link "${config-root}/alacritty";
    ".config/tmux".source = link "${config-root}/tmux";
  };
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Alex Gravem";
    userEmail = "recoeur@proton.me";
    extraConfig = { pull = { rebase = true; }; };
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    extraPackages = with pkgs; [
	gcc
	gnumake
	unzip
	ripgrep
	nodejs_21
    ];
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

