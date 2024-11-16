{ config, pkgs, ... }:

{
  # Enable the OpenSSH daemon.

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
  };
}
