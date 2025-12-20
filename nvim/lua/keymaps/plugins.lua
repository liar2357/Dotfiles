-- バッファ切り替え
vim.keymap.set("n", "<leader>bn", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<Cmd>BufferPrevious<CR>", { desc = "Previous buffer" })

-- 特定バッファにジャンプ（1〜9あたり）
for i = 1, 9 do
  vim.keymap.set("n", "<leader>b" .. i, string.format("<Cmd>BufferGoto %d<CR>", i), { desc = "Go to buffer " .. i })
end

-- 現在のバッファを閉じる
vim.keymap.set("n", "<leader>bd", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })

-- Diffview を開く／閉じる
vim.keymap.set("n", "<leader>dd", "<Cmd>DiffviewOpen<CR>", { desc = "Open diff view" })
vim.keymap.set("n", "<leader>dc", "<Cmd>DiffviewClose<CR>", { desc = "Close diff view" })

-- ファイル履歴を表示（カレントファイル）
vim.keymap.set("n", "<leader>dh", "<Cmd>DiffviewFileHistory %<CR>", { desc = "Diffview file history" })

-- 表示切り替えなど（view 内で使うローカルマップも設定可能）
-- 例: view に入ったときにキーマップをバッファローカル設定
require('diffview').setup({
  keymaps = {
    view = {
      { "n", "<leader>e", require('diffview.actions').focus_files, { desc = "Focus files panel" } },
      { "n", "<leader>b", require('diffview.actions').toggle_files, { desc = "Toggle files panel" } },
      { "n", "g<C-x>", require('diffview.actions').cycle_layout, { desc = "Cycle layout" } },
    },
  }
})

-- ナビゲーション
vim.keymap.set("n", "]g", "<Cmd>Gitsigns next_hunk<CR>", { desc = "Next Git hunk" })
vim.keymap.set("n", "[g", "<Cmd>Gitsigns prev_hunk<CR>", { desc = "Prev Git hunk" })

-- プレビューと blame
vim.keymap.set("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>", { desc = "Preview Git hunk" })
vim.keymap.set("n", "<leader>gb", "<Cmd>Gitsigns blame_line<CR>", { desc = "Blame current line" })

-- ステージ、リセット、アンステージ
vim.keymap.set("n", "<leader>gs", "<Cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>gu", "<Cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })

-- バッファ全体
vim.keymap.set("n", "<leader>gS", "<Cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
vim.keymap.set("n", "<leader>gR", "<Cmd>Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })

vim.keymap.set("n", "<leader>hc", function()
  require("hlchunk").toggle_chunk()
end, { desc = "Toggle indent chunk highlighting" })

vim.keymap.set("n", "<leader>hi", function()
  require("hlchunk").toggle_inlay()  -- もし inlay や補助線があるなら
end, { desc = "Toggle inlay hints / chunk lines" })

-- toggleterm 経由で lazygit をフロート起動
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true,
})

vim.keymap.set({ "n", "t" }, "<leader>lg", function()
  lazygit:toggle()
end, { desc = "Toggle Lazygit" })

vim.keymap.set("n", "<leader>lr", function()
  require("lualine").refresh()
end, { desc = "Refresh lualine" })

-- メッセージ履歴を開く
vim.keymap.set("n", "<leader>nh", function()
  require("noice").history.show({ mode = "notification" })
end, { desc = "Show Noice message history" })

-- コマンドラインモード入力をトグル（例）
vim.keymap.set("n", "<leader>ni", function()
  require("noice").cmdline.toggle()
end, { desc = "Toggle Noice cmdline" })

vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus on file explorer" })

-- 例: テキストオブジェクトを使った選択
vim.keymap.set({ "o", "x" }, "af", ":<C-U>lua require('nvim-treesitter.textobjects.select').select_textobject('function.outer')<CR>", { desc = "Select outer function" })
vim.keymap.set({ "o", "x" }, "if", ":<C-U>lua require('nvim-treesitter.textobjects.select').select_textobject('function.inner')<CR>", { desc = "Select inner function" })

-- 例: 次／前の関数やクラスに移動（移動モジュールがあれば）
vim.keymap.set("n", "]f", function()
  require('nvim-treesitter').goto_next_start('function.outer')
end, { desc = "Next function start" })
vim.keymap.set("n", "[f", function()
  require('nvim-treesitter').goto_previous_start('function.outer')
end, { desc = "Prev function start" })
