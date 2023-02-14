# wall-utils

a flake for my wallpapers and some wallpaper related utils for nixos.

### Packages
+ **[Swww](https://github.com/Horus645/swww)**: wallpaper daemon for wayland
+ **wallpapers**: wallpapers with custom rofi script for changing wallpapers

### Flake Usage

```
{
  description = "A very basic flake";

  inputs = {
    wall-utils.url = "github:sachnr/wallpapers";
  };

  outputs = { self, ... }@inputs: {
    nixosConfigurations.host = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          nixpkgs.overlays = [
              inputs.wall-utils.overlay
          ];
        }
        ./configuration.nix
      ];
    };
  };
}
```
then
```
environment.systemPackages = with pkgs; [
    swww
    wallpapers
];
```
