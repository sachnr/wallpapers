# wall-utils

a flake for my wallpapers and some wallpaper related utils for nixos.

### Packages

- **[Swww](https://github.com/Horus645/swww)**: wallpaper daemon for wayland
- **rofi-wallpaper**: wallpapers with custom rofi script for changing wallpapers

![](/rofi/sample.png)

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
    rofi-wallpaper
];
```

### Home manager options

```
modules = [
    wall-utils.homeManagerModules.default
    {
        programs.wall-utils = {
            enable = true;
            swww.enable = true;
            customCommand = "swww img";
            customDir = "$HOME/Pictures";
            background = "#323D43FF";
            background-alt = "#3C474DFF";
            foreground = "#DAD1BEFF";
            selected = "#7FBBB3FF";
            active = "#A7C080FF";
            urgent = "#E67E80FF";
            font = "RobotoMono Nerd Font 9";
        };
    }
];

```
