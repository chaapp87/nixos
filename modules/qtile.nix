{ config, pkgs, pkgs-stable, pkgs-oldstable, ... }:

{

  services.xserver.windowManager.qtile = {
    enable = true;
    package = pkgs.qtile;
  };
  # Enable the OpenSSH daemon.

}
