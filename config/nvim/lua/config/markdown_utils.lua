-- lua/config/markdown_utils.lua
local M = {}


-- 太字
function M.bold()
  vim.api.nvim_set_current_line("**" .. vim.api.nvim_get_current_line() .. "**")
end

-- 斜体
function M.italic()
  vim.api.nvim_set_current_line("*" .. vim.api.nvim_get_current_line() .. "*")
end

-- 打ち消し線
function M.strikethrough()
  vim.api.nvim_set_current_line("~~" .. vim.api.nvim_get_current_line() .. "~~")
end

-- チェックボックストグル
function M.toggle_checkbox()
  local line = vim.api.nvim_get_current_line()
  if line:match("^%s*%[%s%]") then
    vim.api.nvim_set_current_line(line:gsub("^%s*%[ %]", "[x]"))
  elseif line:match("^%s*%[x%]") then
    vim.api.nvim_set_current_line(line:gsub("^%s*%[x%]", "[ ]"))
  end
end

-- 水平線
function M.horizontal_rule()
  vim.api.nvim_set_current_line("---")
end

-- リンク
function M.link_template()
  vim.api.nvim_set_current_line("[Link text](url)")
end

-- HTML コメント
function M.comment()
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_set_current_line("<!-- " .. line .. " -->")
end

-- 引用
function M.quote()
  vim.api.nvim_set_current_line("> " .. vim.api.nvim_get_current_line())
end

-- リスト（unordered）
function M.unordered_list()
  vim.api.nvim_set_current_line("- " .. vim.api.nvim_get_current_line())
end

-- リスト（ordered）
function M.ordered_list()
  vim.api.nvim_set_current_line("1. " .. vim.api.nvim_get_current_line())
end

-- 画像挿入 (ノーマルモードで URL を入力して挿入)
function M.insert_image()
  vim.api.nvim_set_current_line("![Alt text](url)")
end

-- H1
function M.H1()
  vim.api.nvim_set_current_line("# " .. vim.api.nvim_get_current_line())
end

-- H2
function M.H2()
  vim.api.nvim_set_current_line("## " .. vim.api.nvim_get_current_line())
end

-- H3
function M.H3()
  vim.api.nvim_set_current_line("### " .. vim.api.nvim_get_current_line())
end

-- コードブロック挿入 (```lang … ```)
function M.insert_codeblock()
  local t = {
    "```lang",
    "",
    "```"
  }
  vim.api.nvim_buf_set_lines(0, vim.api.nvim_win_get_cursor(0)[1], vim.api.nvim_win_get_cursor(0)[1], false, t)

end

return M