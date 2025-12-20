require("toggleterm").setup({
  size = 20,                       -- 垂直／水平ターミナルのサイズ（行・列数など）
  open_mapping = [[<leader>t]],        -- ターミナルを開く・閉じるキー
  hide_numbers = true,             -- ターミナルバッファで番号を隠す
  shade_filetypes = {},            -- シェードを無効にしたい filetype があれば追加
  shade_terminals = true,          -- ターミナル背景を暗く（シェード）する
  shading_factor = 2,               -- シェードの濃さ
  start_in_insert = true,          -- ターミナルを開いたら自動で挿入モードに
  insert_mappings = true,           -- 挿入モードでもキーで ToggleTerm を使うか
  terminal_mappings = true,         -- ターミナルモード自体のマッピングを有効にするか
  persist_size = true,              -- ターミナルを開いた時のサイズを覚える
  direction = "horizontal",         -- ターミナルの表示方向: "vertical", "horizontal", "float"
  close_on_exit = false,            -- ターミナルのプロセス終了時にウィンドウを閉じるか
  shell = vim.o.shell,              -- 使うシェル (例: bash, zsh など)
  float_opts = {                    -- フロートモード時の設定
    border = "double",              -- 枠の種類 (例: "single", "double", "curved")
    width = 80,                      -- フロートの幅
    height = 20,                     -- フロートの高さ
    winblend = 3,                    -- 背景透過 (0〜100)
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
  -- ターミナルを開いたとき / 閉じたときのコールバック
  on_open = function(term)
    vim.cmd("startinsert!")  -- 開いたら挿入モードに
    -- ターミナルで `q` を押したら閉じるマッピング（例）
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  on_close = function(_)
    -- 閉じた時にやりたいことがあればここに
  end,
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit_term = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true,
  -- PowerShell で動かすなら、シェルそのものを指定する必要は基本ないが注意
  on_open = function(term)
    vim.cmd("startinsert!")
  end,
  on_close = function(term)
    -- 必要なら
  end,
})

vim.keymap.set({ "n", "t" }, "<leader>lg", function()
  lazygit_term:toggle()
end, { desc = "Toggle Lazygit via toggleterm" })

-- ターミナル内 (ターミナルモード) でのキー設定
function _G.set_toggleterm_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_toggleterm_keymaps()')