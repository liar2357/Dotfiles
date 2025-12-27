vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.helplang = "ja,en"
require('keymaps.main')

vim.wo.number = true

-- Clipboard provider auto detection
local is_wayland = os.getenv("WAYLAND_DISPLAY") ~= nil
local is_x11     = os.getenv("DISPLAY") ~= nil

if is_wayland then
  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = {
      ["+"] = "wl-copy --type text/plain",
      ["*"] = "wl-copy --primary --type text/plain",
    },
    paste = {
      ["+"] = "wl-paste --no-newline",
      ["*"] = "wl-paste --no-newline --primary",
    },
    cache_enabled = 0,
  }
elseif is_x11 then
  vim.g.clipboard = {
    name = "xclip",
    copy = {
      ["+"] = "xclip -selection clipboard -in",
      ["*"] = "xclip -selection primary -in",
    },
    paste = {
      ["+"] = "xclip -selection clipboard -out",
      ["*"] = "xclip -selection primary -out",
    },
    cache_enabled = 0,
  }
end

-- どちらでも動くように unnamedplus をセット
vim.opt.clipboard = "unnamedplus"

local is_vscode = (vim.g.vscode ~= nil)

if not is_vscode then
  require('config.lazy')

  --require("color.ts_highlight_pastel").setup()
  require("color.ts_highlight_vsc").setup()

  require("config.plugin_conf_init")
  require("keymaps.plugins")
end
