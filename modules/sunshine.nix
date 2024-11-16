{ config, pkgs, ... }:

{
  # Enable the OpenSSH daemon.

  services.sunshine = {
    enable = true;
    autostart = true;
    capSysAdmin = true;
  };
}
