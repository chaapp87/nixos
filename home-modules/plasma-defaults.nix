{ config, pkgs, dotfiles, ... }:
{
programs.plasma = {
    enable = true;


    # Hotkeys
    hotkeys.commands."Link-Helper" = {
      name = "DMlinks";
      key = "Meta+q";
      command = ''alacritty -e "dmlinks-default"'';
    };
    
    #
    # Some high-level settings:
    #
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      #iconTheme = "Breeze-Dark";
      #wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Patak/contents/images/1080x1920.png";
    };
};
}
