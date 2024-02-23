{pkgs, config, ... }:

{
	programs.helix = {
		enable = true;
		defaultEditor = true;

		extraPackages = with pkgs; [
			gcc
			gnumake

			# GO
			go_1_20
			gopls

			# JAVASCRIPT
			nodejs_20
			nodePackages.typescript-language-server
		];
	};

	home.file = let
		link = config.lib.file.mkOutOfStoreSymlink;
	in
	{
		".config/helix/config.toml".source = link "/home/alexg/Code/nix/home/programs/helix/config.toml";
	};

	home.sessionVariables = {
		GOPATH = "$HOME/.local/share/go/1.20";
	};
}
