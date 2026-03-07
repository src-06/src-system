{ pkgs, noctalia-shell, ... }:

{
  imports = [
    ./icon-theme.nix
    noctalia-shell.homeModules.default
  ];

  home.packages = with pkgs; [
    # swayidle
    pywalfox-native # for plugin pywallfox
    ffmpeg # for plugin video-wallpaper
  ];

  programs.noctalia-shell = {
    enable = true;

    # settings = {
    #   general = {
    #     scaleRatio = 0.95;
    #     showScreenCorners = true;
    #     forceBlackScreenCorners = true;
    #   };

    #   ui = {
    #     fontDefault = "Noto Sans";
    #     fontFixed = "JetBrainsMono Nerd Font Mono";
    #     fontFixedScale = 0.8;
    #     panelBackgroundOpacity = 0.8;
    #   };

    #   colorSchemes = {
    #     darkMode = true;
    #     useWallpaperColors = true;
    #     generationMethod = "rainbow";
    #     # predefinedScheme = "Nord";
    #   };

    #   templates = {
    #     activeTemplates = [
    #       {
    #         enabled = true;
    #         id = "cava";
    #       }
    #       {
    #         enabled = true;
    #         id = "niri";
    #       }
    #       {
    #         enabled = true;
    #         id = "qt";
    #       }
    #       {
    #         enabled = true;
    #         id = "kcolorscheme";
    #       }
    #       {
    #         enabled = true;
    #         id = "gtk";
    #       }
    #       {
    #         enabled = true;
    #         id = "btop";
    #       }
    #       {
    #         enabled = true;
    #         id = "pywalfox";
    #       }
    #       {
    #         enabled = true;
    #         id = "kitty";
    #       }
    #     ];
    #   };

    #   wallpaper = {
    #     overviewEnabled = true;
    #     hideWallpaperFilenames = true;
    #   };

    #   bar = {
    #     floating = true;
    #     barType = "floating";
    #     capsuleOpacity = 0.3;
    #     hideOnOverview = true;

    #     widgets = {
    #       left = [
    #         {
    #           id = "Launcher";
    #           enableColorization = true;
    #           iconColor = "primary";
    #         }
    #         {
    #           id = "plugin:dns-switcher";
    #         }
    #         {
    #           id = "SystemMonitor";
    #           iconColor = "secondary";
    #           compactMode = false;
    #           showNetworkStats = true;
    #         }
    #         {
    #           id = "Workspace";
    #           showApplications = true;
    #           unfocusedIconsOpacity = 0.5;
    #           groupedBorderOpacity = 0.5;
    #         }
    #         { id = "ActiveWindow"; }
    #       ];

    #       center = [ ];

    #       right = [
    #         {
    #           id = "MediaMini";
    #           panelShowAlbumArt = true;
    #           panelShowVisualizer = true;
    #         }
    #         { id = "Tray"; }
    #         { id = "NotificationHistory"; }
    #         { id = "Volume"; }
    #         { id = "Brightness"; }
    #         {
    #           id = "Battery";
    #           displayMode = "icon-hover";
    #           showPowerProfiles = true;
    #           showNoctaliaPerformance = true;
    #         }
    #         { id = "Bluetooth"; }
    #         { id = "WiFi"; }
    #         {
    #           id = "plugin:video-wallpaper";
    #         }
    #         {
    #           id = "Clock";
    #           formatHorizontal = "h:mm AP - ddd MMM dd";
    #           tooltipFormat = "h:mm AP - dddd, dd MMMM yyyy";
    #         }
    #         {
    #           id = "ControlCenter";
    #           useDistroLogo = true;
    #         }
    #       ];
    #     };
    #   };

    #   dock.enabled = false;

    #   controlCenter = {
    #     position = "top_right";
    #     cards = [
    #       {
    #         enabled = true;
    #         id = "profile-card";
    #       }
    #       {
    #         enabled = true;
    #         id = "shortcuts-card";
    #       }
    #       {
    #         enabled = true;
    #         id = "audio-card";
    #       }
    #       {
    #         enabled = true;
    #         id = "brightness-card";
    #       }
    #       {
    #         enabled = false;
    #         id = "weather-card";
    #       }
    #       {
    #         enabled = true;
    #         id = "media-sysmon-card";
    #       }
    #     ];
    #   };

    #   appLauncher = {
    #     position = "top_left";
    #     showCategories = false;
    #     enableClipboardHistory = true;
    #     sortByMostUsed = false;
    #     terminalCommand = "kitty -e";
    #   };

    #   osd = {
    #     backgroundOpacity = 0.8;
    #     enabledTypes = [
    #       0
    #       1
    #       2
    #       3
    #     ];
    #   };

    #   sessionMenu = {
    #     position = "top_right";
    #     largeButtonsLayout = "grid";
    #     powerOptions = [
    #       {
    #         action = "lock";
    #         enabled = true;
    #       }
    #       {
    #         action = "logout";
    #         enabled = true;
    #       }
    #       {
    #         action = "suspend";
    #         enabled = true;
    #       }
    #       {
    #         action = "hibernate";
    #         enabled = false;
    #       }
    #       {
    #         action = "reboot";
    #         enabled = true;
    #       }
    #       {
    #         action = "rebootToUefi";
    #         enabled = true;
    #       }
    #       {
    #         action = "shutdown";
    #         enabled = true;
    #       }
    #     ];
    #   };

    #   location = {
    #     name = "Gunung Putri";
    #     use12hourFormat = true;
    #   };

    #   # hooks = {
    #   #   enabled = true;
    #   #   screenLock = "swayidle -w timeout 210 'niri msg action power-off-monitors' timeout 600 'systemctl suspend' before-sleep 'noctalia-shell ipc call lockScreen lock'";
    #   #   screenUnlock = "kill swayidle";
    #   # };
    # };

    # plugins = {
    #   sources = [
    #     {
    #       enabled = true;
    #       name = "Noctalia Plugins";
    #       url = "https://github.com/noctalia-dev/noctalia-plugins";
    #     }
    #   ];
    #   states = {
    #     keybind-cheatsheet = {
    #       enabled = true;
    #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    #     };
    #     polkit-agent = {
    #       enabled = true;
    #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    #     };
    #     translator = {
    #       enabled = true;
    #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    #     };
    #     video-wallpaper = {
    #       enabled = true;
    #       sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    #     };
    #   };
    #   version = 1;
    # };
  };
}
