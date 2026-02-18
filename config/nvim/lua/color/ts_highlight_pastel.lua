-- lua/config/treesitter_highlight.lua
local M = {}

function M.setup()
  vim.api.nvim_set_hl(0, "@keyword",        { fg = "#7BA6D3", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "@keyword.repeat", { fg = "#7BA6D3", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "@function",       { fg = "#8CC38D", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@type",           { fg = "#8CC38D", bg = "NONE", italic = true })
  vim.api.nvim_set_hl(0, "@variable",       { fg = "#D7A6C4", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@constant",       { fg = "#D7A6C4", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@string",         { fg = "#D7A6C4", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@comment",        { fg = "#6F6F6F", bg = "NONE", italic = true })
  vim.api.nvim_set_hl(0, "@operator",       { fg = "#C4A8D7", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@punctuation",    { fg = "#C4A8D7", bg = "NONE" })
end

return M