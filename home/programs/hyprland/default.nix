{ pkgs, config, ... }:

{
  # home.file = let
  #   link = config.lib.file.mkOutOfStoreSymlink;
  # in
  # {
  #   ".config/hypr/hyprland.conf".source = link "/home/alexg/Code/nix/home/programs/hyprland/hyprland.conf";
  # };
}
