{ pkgs, ... }:
{
  imports = [
    ./common
    ./common/desktop
    ./common/hyprland.nix
  ];

  wayland.windowManager.hyprland.settings = {
    "$mod" = "Super";
    bind = [
        # Brightness controls
        ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"

        # Keyboard brightness controls
        '',XF86KbdBrightnessUp, exec, brightnessctl -d "apple::kbd_backlight" set 20%+''
        '',XF86KbdBrightnessDown, exec, brightnessctl -d "apple::kbd_backlight" set 20%-''
    ];
  };

  home.packages = [ pkgs.brightnessctl ];
}