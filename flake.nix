{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    dotfiles.url = "git+ssh://git@github.com/chaapp87/dotfilesnew.git?ref=main";
    dotfiles.flake = false;
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    scripts = {
      url = "git+ssh://git@github.com/chaapp87/chaapp-scripts.git?ref=main";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, jovian, dotfiles, plasma-manager, ... }@inputs: 
    let
      system = "x86_64-linux";
    in
    {
    # Please replace my-nixos with your hostname
      nixosConfigurations =
        let
          rd-nb-nixos-name = "rd-nb-nixos";
          steamdeck-nixos-name = "steamdeck-nixos";
          nb-media-name = "nb-media";
          testvm-hetzner-name = "testvm-hetzner";
          gaming-nixos-name = "gaming-nixos";
        in
          {
            rd-nb-nixos = nixpkgs.lib.nixosSystem {
        
              #_module.args = { inherit scripts; };
              modules = [
                # Import the previous configuration.nix we used,
                # so the old configuration file still takes effect
                ./machines/${rd-nb-nixos-name}/configuration.nix
                ./modules/basepkgs.nix
                ./modules/baseoptions.nix
                ./modules/displayManagers.nix
                ./modules/sunshine.nix
                ./modules/flatpak.nix
                ./modules/docker.nix
                ./modules/ferdium-server.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.chaapp = import ./machines/${rd-nb-nixos-name}/home.nix;
                  home-manager.backupFileExtension = "hm-backup";
                  home-manager.extraSpecialArgs = { inherit dotfiles; };
                  # Optionally, use home-manager.extraSpecialArgs to pass
                  # arguments to home.nix
                  home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
                }
                
                  { _module.args = inputs; }
                
              ];
            };


             nb-media = nixpkgs.lib.nixosSystem {
        
      
              modules = [
                # Import the previous configuration.nix we used,
                # so the old configuration file still takes effect
                ./machines/${nb-media-name}/configuration.nix
                ./modules/basepkgs.nix
                ./modules/baseoptions.nix
                ./modules/openssh.nix
                ./modules/displayManagers.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.media = import ./machines/${nb-media-name}/home.nix;
                  home-manager.backupFileExtension = "hm-backup";
                  # Optionally, use home-manager.extraSpecialArgs to pass
                  # arguments to home.nix
                  home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
                }
              ];
             };

             gaming-nixos = nixpkgs.lib.nixosSystem {
        
      
              modules = [
                # Import the previous configuration.nix we used,
                # so the old configuration file still takes effect
                ./machines/${gaming-nixos-name}/configuration.nix
                ./modules/basepkgs.nix
                ./modules/baseoptions.nix
                ./modules/openssh.nix
                ./modules/sunshine.nix
                ./modules/displayManagers.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.gaming = import ./machines/${gaming-nixos-name}/home.nix;
                  home-manager.backupFileExtension = "hm-backup";
                  # Optionally, use home-manager.extraSpecialArgs to pass
                  # arguments to home.nix
                  home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
                }
              ];
             };

             
             steamdeck-nixos = nixpkgs.lib.nixosSystem {
        
      
              modules = [
                # Import the previous configuration.nix we used,
                # so the old configuration file still takes effect
                {
                  nixpkgs.config.pkgs = import nixpkgs { inherit system; };
                }
                ./machines/${steamdeck-nixos-name}/configuration.nix
                ./modules/basepkgs.nix
                ./modules/baseoptions.nix
                ./modules/sunshine.nix
                ./modules/openssh.nix
                jovian.nixosModules.jovian
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.media = import ./machines/${steamdeck-nixos-name}/home.nix;
                  home-manager.backupFileExtension = "hm-backup";
                  # Optionally, use home-manager.extraSpecialArgs to pass
                  # arguments to home.nix
                  home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
                }
              ];
             };


          };
    };

}
