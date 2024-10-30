# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

   # Bootloader.

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

    networking = {
      hostName = "rd-nb-nixos"; # Define your hostname.
      #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
      # Enable networking
      networkmanager.enable = true;
    };



  # You can disable this if you're only using the Wayland session.
  services = {
    teamviewer.enable = true;
    printing.enable = true;
    pcscd.enable = true;
    blueman.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chaapp = {
    isNormalUser = true;
    linger = true;
    description = "chaapp";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      ];
  };


  # Steam 32 Bit fix
  programs.steam.enable = true; 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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

    user.services.syncthing = {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "default.target" ];
      description = "Syncthing";
      serviceConfig = {
        Type = "simple";
        ExecStart = ''/etc/profiles/per-user/chaapp/bin/syncthing'';
      };
    };
  };
# Environment variables

    system.stateVersion = "24.05"; # Did you read the comment?

  
}
