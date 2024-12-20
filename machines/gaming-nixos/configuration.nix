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
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };

    networking = {
      hostName = "gaming-nixos"; # Define your hostname.
      interfaces.enp8s0.ipv4.addresses = [ {
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
  security.polkit.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    gaming = {
      isNormalUser = true;
      linger = true;
      description = "gaming";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      ];
    };
    chaapp = {
      isNormalUser = true;
      initialPassword = "Password123";
      linger = true;
      home = "/home/chaapp";
      description = "chaapp";
      group = "chaapp";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      ];
    };
  };


  users.groups.chaapp = {};

systemd = {
    user.services.ssh-agent = {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "default.target" ];
      description = "SSH key agent";
      serviceConfig = {
        Type = "simple";
        Environment=''SSH_AUTH_SOCK=%t/ssh-agent.socket'';
        ExecStart = ''/run/current-system/sw/bin/ssh-agent -D -a $SSH_AUTH_SOCK'';
      };
    };
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


services = {
  displayManager.autoLogin.enable = true;
  displayManager.autoLogin.user = "gaming";
  };


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
