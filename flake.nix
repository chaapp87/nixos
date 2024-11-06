{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, jovian, ... }@inputs: 
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
        in
          {
            rd-nb-nixos = nixpkgs.lib.nixosSystem {
        
      
              modules = [
                # Import the previous configuration.nix we used,
                # so the old configuration file still takes effect
                ./machines/${rd-nb-nixos-name}/configuration.nix
                ./modules/basepkgs.nix
                ./modules/baseoptions.nix
                ./modules/displayManagers.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.chaapp = import ./machines/${rd-nb-nixos-name}/home.nix;
                  home-manager.backupFileExtension = "hm-backup";
                  # Optionally, use home-manager.extraSpecialArgs to pass
                  # arguments to home.nix
                }
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
                }
              ];
             };

             steamdeck-nixos = nixpkgs-unstable.lib.nixosSystem {
        
      
              modules = [
                # Import the previous configuration.nix we used,
                # so the old configuration file still takes effect
                {
                  nixpkgs.config.pkgs = import nixpkgs-unstable { inherit system; };
                }
                ./machines/${steamdeck-nixos-name}/configuration.nix
                ./modules/basepkgs.nix
                ./modules/baseoptions.nix
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
                }
              ];
             };


          };
    };

}
