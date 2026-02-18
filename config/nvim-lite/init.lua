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

