{ pkgs, config, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    WRL_NO_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; }))
    dunst
    libnotify
    swww # wallpaper  
    wofi # menu
    kitty
  ];

  xdg.portal.enable = true;
}
