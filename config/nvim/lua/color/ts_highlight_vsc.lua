-- lua/config/treesitter_highlight.lua
local M = {}

function M.setup()
  -- 基本的なキーワード等
  vim.api.nvim_set_hl(0, "@keyword",             { fg = "#569CD6", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "@keyword.repeat",      { fg = "#c060dd", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "@function",            { fg = "#ffff50", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@type",                { fg = "#30baBa", bg = "NONE"})
  vim.api.nvim_set_hl(0, "@variable",            { fg = "#9CDCFE", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@constant",            { fg = "#DCDCAA", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@string",              { fg = "#CE9178", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@comment",             { fg = "#6A9955", bg = "NONE", italic = true })
  vim.api.nvim_set_hl(0, "@operator",            { fg = "#D4D4D4", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@punctuation",         { fg = "#D4D4D4", bg = "NONE" })

  -- HTML／web系タグ・属性用（判別しやすくするため別色）
  vim.api.nvim_set_hl(0, "@tag",                  { fg = "#569CD6", bg = "NONE", bold = true })     -- タグ名
  vim.api.nvim_set_hl(0, "@tag.attribute",        { fg = "#9CDCFE", bg = "NONE" })                  -- 属性名
  vim.api.nvim_set_hl(0, "@tag.attribute.value",  { fg = "#CE9178", bg = "NONE" })                  -- 属性値
  vim.api.nvim_set_hl(0, "@punctuation.bracket",  { fg = "#D4D4D4", bg = "NONE" })                  -- 開き・閉じ括弧
  vim.api.nvim_set_hl(0, "@text.diagnostic",      { fg = "#D16969", bg = "NONE" })                  -- 警告テキスト等（例：誤り表示）

  --補足
  vim.api.nvim_set_hl(0, "@string.escape",          { fg = "#2060c0", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@function.call",          { fg = "#ffff50", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@function.macro",         { fg = "#ffff50", bg = "NONE" })
  vim.api.nvim_set_hl(0, "@type.builtin",           { fg = "#30baba", bg = "NONE" })

  return M
end

return M