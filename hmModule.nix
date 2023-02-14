self: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.wall-utils;
in
  with lib; {
    options.programs.wall-utils = {
      enable = mkEnableOption "wallpaper collection + rofi script";

      customCommand = mkOption {
        default = "swww img";
        type = types.nullOr types.str;
        description = "wallpaper command";
      };

      background = mkOption {
        default = "#323D43FF";
        type = types.nullOr types.str;
        description = "background color for rofi";
      };

      background-alt = mkOption {
        default = "#3C474DFF";
        type = types.nullOr types.str;
        description = "background-alt color for rofi";
      };

      foreground = mkOption {
        default = "#DAD1BEFF";
        type = types.nullOr types.str;
        description = "foreground color for rofi";
      };

      selected = mkOption {
        default = "#7FBBB3FF";
        type = types.nullOr types.str;
        description = "selected color for rofi";
      };

      active = mkOption {
        default = "#A7C080FF";
        type = types.nullOr types.str;
        description = "active color for rofi";
      };

      urgent = mkOption {
        default = "#E67E80FF";
        type = types.nullOr types.str;
        description = "urgent color for rofi";
      };

      font = mkOption {
        default = "JetBrainsMono Nerd Font 9";
        type = types.nullOr types.str;
        description = "font for rofi";
      };

      swww = {
        enable = mkEnableOption "swww, a solution to your wayland wallpaper woes";

        package = mkOption {
          type = types.package;
          default = self.swww;
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = let
        wallpaper-final = self.wallpapers.overrideAttrs (oldAttrs: rec {
          installPhase =
            oldAttrs.installPhase
            + ''
              substituteInPlace $out/share/rofi/themes/wallpaper.rasi \
                --replace "#323D43FF" "${cfg.background}" \
                --replace "#3C474DFF" "${cfg.background-alt}" \
                --replace "#DAD1BEFF" "${cfg.foreground}" \
                --replace "#7FBBB3FF" "${cfg.selected}" \
                --replace "#A7C080FF" "${cfg.active}" \
                --replace "#E67E80FF" "${cfg.urgent}" \
                --replace "JetBrainsMono Nerd Font 9" "${cfg.font}"
              substituteInPlace $out/share/rofi/script/rofi-modi \
                --replace "swww img" "${cfg.customCommand}"
            '';
        });
      in
        [
          wallpaper-final
        ]
        ++ lib.optionals cfg.swww.enable [cfg.swww.package];
    };
  }
