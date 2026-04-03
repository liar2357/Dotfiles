vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.helplang = "ja,en"
require("keymaps.main")

vim.wo.number = true

-- =========================================
-- Universal Clipboard (WezTerm / SSH / Wayland 対応・安定版)
-- =========================================

-- clipboard providerは使わない（これ重要）
vim.opt.clipboard = ""
vim.g.clipboard = nil

local function is_ssh()
  return os.getenv("SSH_TTY") ~= nil
end

local function is_wayland()
  return os.getenv("WAYLAND_DISPLAY") ~= nil
end

-- =========================================
-- Yank時に強制同期（これが本体）
-- =========================================
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    -- unnamed registerから取得
    local text = vim.fn.getreg('"')
    local regtype = vim.fn.getregtype('"')

    if not text or text == "" then
      return
    end

    local lines = vim.split(text, "\n")

    -- 末尾の空行だけ削除（重要）
    while #lines > 1 and lines[#lines] == "" do
      table.remove(lines)
    end

    -- nvim内部の + レジスタに同期
    vim.fn.setreg("+", lines, regtype)

    -- =====================================
    -- 外部クリップボードへ
    -- =====================================

    if is_ssh() then
      -- OSC52（WezTerm対応：copy only）
      local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
      if ok then
        osc52.copy("+")(lines, regtype)
      end
    elseif is_wayland() then
      -- wl-copy
      vim.fn.system("wl-copy --type text/plain --trim-newline", text)
    end
  end,
})

-- =========================================
-- 補助：+レジスタから貼れるようにする（保険）
-- =========================================
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { noremap = true })

local is_vscode = (vim.g.vscode ~= nil)

if not is_vscode then
  vim.o.shell = vim.fn.exepath("zsh")

  vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
      -- 現在のウィンドウ番号を取得
      local current_win = vim.api.nvim_get_current_win()
      -- すべてのウィンドウをループして調べる
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        -- カレント以外を調査
        if win ~= current_win then
          local buf = vim.api.nvim_win_get_buf(win)
          -- buftypeが空文字（通常のバッファ）があればループ終了
          if vim.bo[buf].buftype == "" then
            return
          end
        end
      end
      -- ここまで来たらカレント以外がすべて特殊ウィンドウということなので
      -- カレント以外をすべて閉じる
      vim.cmd.only({ bang = true })
      -- この後、ウィンドウ1つの状態でquitが実行されるので、Vimが終了する
    end,
    desc = "Close all special buffers and quit Neovim",
  })

  require("config.lazy")

  --require("color.ts_highlight_pastel").setup()
  require("color.ts_highlight_vsc").setup()

  require("config.plugin_conf_init")
  require("keymaps.plugins")
end
