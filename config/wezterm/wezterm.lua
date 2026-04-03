local wezterm = require("wezterm")

return {
  font = wezterm.font("font_family Cascadia Code NF"),
  font_size = 14.0,

  color_scheme = "Builtin Solarized Dark",

  front_end = "WebGpu", -- ←描画安定
  -- enable_wayland = false, -- ←XWayland fallback（安定重視）

  hide_tab_bar_if_only_one_tab = true,

  window_decorations = "NONE", -- Hyprlandと相性良い

  term = "wezterm",
  set_environment_variables = {
    TERMINFO_DIRS = "/home/yourname/.nix-profile/share/terminfo",
  },
}
