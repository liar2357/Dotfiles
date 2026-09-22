--############################
--## ENVIRONMENT VARIABLES ###
--############################

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("GTK_THEME", "Adwaita:dark")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

hl.env("ELECTRON_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

hl.env("XDG_PICTURES_DIR", "$HOME/Pictures")
hl.env("HYPRSHOT_DIR", "$HOME/Pictures/screenshot")

--###############
--## MONITORS ###
--###############

hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto-down",
  scale = "1.0",
})

hl.workspace_rule({
  workspace = "1",
  monitor = "eDP-1",
})

--############
--## INPUT ###
--############

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})

hl.config({
  input = {
    kb_layout = "jp",
    follow_mouse = 1,
    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    touchpad = {
      natural_scroll = true,
      clickfinger_behavior = true,
      tap_to_click = true,
    },
    tablet = {
      output = "eDP-1",
    },
  },
  -- Example per-device config
  xwayland = {
    force_zero_scaling = true,
  },
})

--################
--## AUTOSTART ###
--################
--
hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start nixos-fake-graphical-session.target")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("~/Dotfiles/scripts/bin/autostart-hyprpaper")
  hl.exec_cmd("~/Dotfiles/scripts/bin/autoreroad-waybar")
  hl.exec_cmd("fcitx5")
  hl.exec_cmd("swaync")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("wl-clip-persist --clipboard regular")
  hl.exec_cmd("blueman-applet")
  hl.exec_cmd("nm-applet --indicator")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1")
  hl.exec_cmd("emu-board")
end)

hl.on("config.reloaded", function()
  hl.exec_cmd("kdeconnectd")
end)
