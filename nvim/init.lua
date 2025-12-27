vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.helplang = "ja,en"
require('keymaps.main')

vim.wo.number = true

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
}

local is_vscode = (vim.g.vscode ~= nil)

if not is_vscode then
  require('config.lazy')

  --require("color.ts_highlight_pastel").setup()
  require("color.ts_highlight_vsc").setup()

  require("config.plugin_conf_init")
  require("keymaps.plugins")
end
