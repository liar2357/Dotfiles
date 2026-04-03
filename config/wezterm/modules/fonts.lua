local wezterm = require("wezterm")
local M = {}

function M.apply(config)
  config.font = wezterm.font_with_fallback({
    "Moralerspace Argon HWNF",
    "Noto Sans CJK JP",
    "Noto Color Emoji",
  })
  config.font_size = 12.0
end

return M
