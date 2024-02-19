{pkgs, config, ...}:

{
    home.packages = with pkgs; [
        ripgrep
        fd
        lua-language-server
    ];

    home.file =
    let
        link = config.lib.file.mkOutOfStoreSymlink;
    in {
        ".config/nvim".source = link "/home/alexg/Code/nix/home/programs/neovim/nvim";
    };

    programs.neovim = {
        enable = true;
        vimAlias = true;
        viAlias = true;
        vimdiffAlias = true;

        plugins = with pkgs.vimPlugins; [ 
            nvim-lspconfig
            comment-nvim
            gruvbox-nvim
            nvim-treesitter.withAllGrammars 
        ];
    };
}