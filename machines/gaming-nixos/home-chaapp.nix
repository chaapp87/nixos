{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "chaapp";
  home.homeDirectory = "/home/chaapp";

  home.sessionVariables = {
  SSH_AUTH_SOCK="/run/user/993/ssh-agent.socket";
 
};

  imports = [
  ../../home-modules/plasma-defaults.nix
  ];

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    
    steam
    moonlight-qt
    syncthing
    syncthing-tray
#    retroarchFull
    dmenu
    discord
    chromium
    cabextract
    wget
    obs-studio
    keepassxc
 
   
  ];



  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "chaapp1987";
    userEmail = "roland@douven-online.de";
  };




# Mailaccount

  # starship - an customizable prompt for any shell
#  programs.starship = {
#    enable = true;
#    # custom settings
#    settings = {
 #     add_newline = false;
 #     aws.disabled = true;
 #     gcloud.disabled = true;
 #     line_break.disabled = true;
 #   };
 # };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      ec = "emacsclient -c -n -a ''";
    };
  };

  programs.firefox = {
    enable = true;
    profiles.chaapp.name = "chaapp";
    profiles.chaapp.id = 0;
    profiles.chaapp.isDefault = true;
    profiles.chaapp.bookmarks = [

      {
        name = "Nix sites";
        toolbar = true;
        bookmarks = [
      
          {
            name = "Dennsen86";
            keyword = "twitch";
            url = "https://www.twitch.tv/dennsen86";
          }
          {
            name = "Nayfal";
            keyword = "twitch";
            url = "https://www.twitch.tv/nayfal";
          }
          {
            name = "Twitch Startseite";
            keyword = "twitch";
            url = "https://www.twitch.tv";
          }
          {
            name = "Youtube";
            keyword = "youtube";
            url = "https://www.youtube.com";
          }
        ];
      }
    ];
      
    profiles.chaapp.settings = {
      "browser.toolbars.bookmarks.visibility" = "always";
      "browser.search.region" = "DE";
    };
    
  };
    
programs.emacs = {
    enable = true;
     package = pkgs.emacs29;
  };
  services.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };
  
  
  
  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.



  programs.home-manager.enable = true;

  # Link my own dotfiles
  # emacs

  # Sway Config 
  #home.file."${config.xdg.configHome}/sway/config" = {
  #  source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/sway/config-nb-media";
  #};

  # Waybar config
  #home.file."${config.xdg.configHome}/waybar/config" = {
  #  source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/config/waybar/config-nb-media";
  #};

# "/home/chaapp/dotfilesnew/roles/emacs/files/init-rd-nb-nixos.el"
#  home.file.".config/emacs/init.el" = {
#    source = ../../../roles/emacs/files/init-rd-nb-nixos.el;
#  };
  #xdg.configFile."emacs/init.el".source = ../../../dotfilesnew/roles/emacs/files/init-rd-nb-nixos.el;
   home.file."${config.xdg.configHome}/emacs/init.el" = {
     source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfilesnew/roles/emacs/files/init-rd-nb-nixos.el";
   };
    

  
}



