{ pkgs, config, ... }:

{
  home.file =
    let
      link = config.lib.file.mkOutOfStoreSymlink;
    in
    {
      ".config/nvim".source = link "/home/alexg/Code/nix/home/programs/neovim/nvim";
    };

  home.sessionVariables = {
    GOPATH = "$HOME/.local/share/go/1.20";
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      gcc
      gnumake
      fzf
      ripgrep
      wl-clipboard
      xclip

      # LUA
      lua-language-server
      stylua

      # GO
      go_1_20
      gopls
      golangci-lint

      # NIX
      rnix-lsp

      # JAVASCRIPT
      nodejs_20
    ];

    plugins = with pkgs.vimPlugins; [
      gruvbox-material
    ];
  };
}
