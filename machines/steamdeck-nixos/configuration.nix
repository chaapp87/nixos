# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable the Flakes feature and the accompanying new nix command-line tool

  # Bootnloader.

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

    networking = {
      hostName = "steamdeck-nixos"; # Define your hostname.
      interfaces.enp4s0f3u1u1.ipv4.addresses = [ {
        address = "192.168.178.191";
        prefixLength = 24;
      } ];
      defaultGateway = "192.168.178.1";
      nameservers = [ "192.168.178.1" "8.8.8.8" ];
      #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      # Enable networking
      networkmanager.enable = true;
    };
  systemd.network.wait-online.anyInterface = true;
  # Set your time zone.

  # You can disable this if you're only using the Wayland session.
  services = {
    blueman.enable = true;
  };

  
    # Jovian Settings
    jovian.devices.steamdeck.enable = true;
    jovian.steam.enable = true;
    jovian.steam.autoStart = true;

    jovian.steam.desktopSession = "plasma";
    jovian.steam.user = "media";


  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.media = {
    isNormalUser = true;
    linger = true;
    description = "media";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      ];
  };

  # Steam 32 Bit fix
  programs.steam.enable = true; 

  programs.sway.enable = true;
  programs.waybar.enable = true;


  # jovian.devices.steamdeck.enableControllerUdevRules = true;
  # jovian.steamos.enableBluetoothConfig = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

fonts.packages = with pkgs; [
    font-awesome
    inter
   ];


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?


# Environment variables

}
