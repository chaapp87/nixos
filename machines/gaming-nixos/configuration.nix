# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

   # Bootnloader.
  
  boot = {
    loader.grub.enable = true;
    loader.grub.device = "/dev/sda";
    loader.grub.useOSProber = true;
  };

    networking = {
      hostName = "gaming-nixos"; # Define your hostname.
      interfaces.eno1.ipv4.addresses = [ {
        address = "192.168.178.87";
        prefixLength = 24;
      } ];
      defaultGateway = "192.168.178.1";
      nameservers = [ "192.168.178.1" "8.8.8.8" ];
      #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      # Enable networking
      networkmanager.enable = true;
    };
   # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  
  # Enable bluetooth
  
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gaming = {
    isNormalUser = true;
    linger = true;
    description = "media";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Steam 32 Bit fix
  programs.steam.enable = true; 

  #programs.sway.enable = true;
  #programs.waybar.enable = true;
  

  


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

    system.stateVersion = "24.05"; # Did you read the comment?

# Environment variables

}
