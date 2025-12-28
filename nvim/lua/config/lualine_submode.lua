local sm = require("nvim-submode")

-- モードコードから人間向けラベルへのマッピング
local mode_alias = {
  n  = "NORMAL",
  no = "NORMAL-PENDING",
  i  = "INSERT",
  ic = "INSERT-COMPLETE",
  ix = "INSERT-COMPLETE",
  R  = "REPLACE",
  Rc = "REPLACE-COMPLETE",
  Rv = "VREPLACE",
  V  = "VISUAL-LINE",
  v  = "VISUAL",
  [''] = "VISUAL-BLOCK", -- CTRL+V
  s  = "SELECT",
  S  = "SELECT-LINE",
  [''] = "SELECT-BLOCK", -- CTRL+S
  c  = "COMMAND",
  ce = "COMMAND-EX",
  r  = "PROMPT",
  rm = "MORE",
  ['r?'] = "CONFIRM",
  ['!'] = "SHELL",
  t  = "TERMINAL"
}

local function get_mode_name()
  local sub = sm.get_submode_name()
  if sub then
    return sub  -- サブモードがあればそれを優先
  end

  -- 通常モード名を 1 文字だけでなく full モードで取得
  local raw = vim.fn.mode(1)
  -- マッピングがあればわかりやすいラベルで返す
  return mode_alias[raw] or raw
end

return {
  mode_or_submode = get_mode_name,
}