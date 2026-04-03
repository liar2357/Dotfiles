local wezterm = require("wezterm")
local M = {}

function M.apply(config)
  config.front_end = "WebGpu" -- ←描画安定
  config.window_decorations = "NONE" -- Hyprlandと相性良い

  config.color_scheme = "Monokai Remastered"

  config.term = "wezterm"
  config.set_environment_variables = {
    TERMINFO_DIRS = "/home/raia/.nix-profile/share/terminfo",
  }
end

return M
