{ config, pkgs, inputs, ... }:

{ 
  imports = [ 
    ./hardware.nix 
    ./modules/hyprland.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true; boot.loader.efi.canTouchEfiVariables = true;
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  # Graphical Card
  hardware.opengl = { 
    enable = true; 
    driSupport = true; 
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.keyboard.zsa.enable = true;

  networking.hostName = "huggin";

  networking.extraHosts = ''
  127.0.0.1 www.edgee.dev
  127.0.0.1 api.edgee.dev
  127.0.0.1 console.edgee.dev
  127.0.0.1 event.edgee.dev
  '';

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true; 
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = { 
    xkb.layout = "us"; 
    xkb.variant = "";
  };

  # Enable sound with pipewire.
  sound.enable = true; 
  hardware.pulseaudio.enable = false; 
  security.rtkit.enable = true; 
  services.pipewire = {
    enable = true; 
    alsa.enable = true; 
    alsa.support32Bit = true; 
    pulse.enable = true;
  };

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alexg = { 
    isNormalUser = true; 
    shell = pkgs.zsh;
    description = "Alex Gravem"; 
    extraGroups = [ "networkmanager" "wheel" "docker" ]; 
    packages = with pkgs; [ ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true; 
  services.xserver.displayManager.autoLogin.user = "alexg";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false; 
  systemd.services."autovt@tty1".enable = false;

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hybernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    chromium
  ];

  # Enable the OpenSSH daemon. 
  # services.openssh.enable = true;

  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
  };

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;

    packages = with pkgs; [
      nanum
      #iosevka
      #(iosevka.override { set = "ss07"; })
      #(iosevka.override { set = "ss10"; })
      #(iosevka.override { set = "ss12"; })
      #(iosevka.override { set = "term"; })
    ];
  };

  # This value determines the NixOS release from which the default settings for stateful data, like file 
  # locations and database versions on your system were taken. It‘s perfectly fine and recommended to leave 
  # this value at the release version of the first install of this system. Before changing this value read the 
  # documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
