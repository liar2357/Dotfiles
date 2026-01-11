vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.helplang = "ja,en"
require('keymaps.main')

vim.wo.number = true

-- Clipboard provider auto detection
local is_wayland = os.getenv("WAYLAND_DISPLAY") ~= nil
local is_x11     = os.getenv("DISPLAY") ~= nil
local is_ssh     = os.getenv("SSH_TTY") ~= nil

if is_ssh then
  -- ssh セッションでは OSC52 を優先
  vim.g.clipboard = "osc52"

elseif is_wayland then
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

vim.opt.clipboard = "unnamedplus"


local is_vscode = (vim.g.vscode ~= nil)

if not is_vscode then
  vim.api.nvim_create_autocmd('QuitPre', {
    callback = function()
      -- 現在のウィンドウ番号を取得
      local current_win = vim.api.nvim_get_current_win()
      -- すべてのウィンドウをループして調べる
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        -- カレント以外を調査
        if win ~= current_win then
          local buf = vim.api.nvim_win_get_buf(win)
          -- buftypeが空文字（通常のバッファ）があればループ終了
          if vim.bo[buf].buftype == '' then
            return
          end
        end
      end
      -- ここまで来たらカレント以外がすべて特殊ウィンドウということなので
      -- カレント以外をすべて閉じる
      vim.cmd.only({ bang = true })
      -- この後、ウィンドウ1つの状態でquitが実行されるので、Vimが終了する
    end,
    desc = 'Close all special buffers and quit Neovim',
  })

  require('config.lazy')

  --require("color.ts_highlight_pastel").setup()
  require("color.ts_highlight_vsc").setup()

  require("config.plugin_conf_init")
  require("keymaps.plugins")
end
