{
  description = "nix flake for wallpaper related stuff";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs @ {self, ...}: let
    inherit (inputs.nixpkgs) lib;
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in
    with lib; {
      rofi-wallpaper = pkgs.callPackage ./pkg.nix {};
      # swww = pkgs.callPackage ./swww.nix {};
      overlay = final: prev: {
        rofi-wallpaper = self.rofi-wallpaper;
        # swww = self.swww;
      };
      homeManagerModules.default = import ./hmModule.nix self;
    };
}
