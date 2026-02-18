-- 以下のキーアサインは個別設定
-- toggle_term -> ターミナルを開く
-- lspconfig -> 定義参照等
-- cmp -> 補完系
-- comment-box -> コメントボックス/コメントライン
-- vim-operator-convert-case -> ケース変換
-- vim-operator-replace -> レジスタの内容で選択範囲を置換
-- winresizer -> ウインドウサイズ変更


-- バッファ切り替え
vim.keymap.set("n", "<C-l>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-h>", "<Cmd>BufferPrevious<CR>", { desc = "Previous buffer" })

-- 特定バッファにジャンプ（1〜9あたり）
for i = 1, 9 do
  vim.keymap.set("n", "<leader>b" .. i, string.format("<Cmd>BufferGoto %d<CR>", i), { desc = "Go to buffer " .. i })
end

-- 現在のバッファを閉じる
vim.keymap.set("n", "<leader>q", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>q!", "<Cmd>bd!<CR>", { desc = "Close buffer OVERRIDE" })

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

vim.keymap.set("n", "<leader>lr", function()
  require("lualine").refresh()
end, { desc = "Refresh lualine" })

-- メッセージ履歴を開く
vim.keymap.set("n", "<leader>nh", function()
  vim.cmd("Noice history")
end, { desc = "Show Noice history" })

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
local move = require("nvim-treesitter-textobjects.move")
vim.keymap.set("n", "]f", function()
  move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set("n", "[f", function()
  move.goto_previous_start("@function.outer", "textobjects")
end)

-- accelerated-jk
vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)", { silent = true })
vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)", { silent = true })

-- auto_save
vim.keymap.set("n", "<leader>as", "<Cmd>ASToggle<CR>", { desc = "Toggle AutoSave" })

-- dial
vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { desc = "Dial Increment" })
vim.keymap.set("n", "<C-d>", require("dial.map").dec_normal(), { desc = "Dial Decrement" })

-- dropbar
vim.keymap.set("n", "<leader>;", require("dropbar.api").pick, { desc = "Dropbar Pick" })

-- glance
vim.keymap.set('n', 'gd', '<Cmd>Glance definitions<CR>', { desc = "Glance Definitions" })
vim.keymap.set('n', 'gr', '<Cmd>Glance references<CR>', { desc = "Glance References" })

-- namu
vim.keymap.set("n", "<leader>sc", ":Namu symbols<cr>")
vim.keymap.set("n", "<leader>sw", ":Namu workspace<cr>")
vim.keymap.set("n", "<leader>wa", ":Namu diagnostics<cr>")

-- telescope
vim.keymap.set("n", "<leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>", { desc = "Grep in project" })
vim.keymap.set("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "List buffers" })

-- translator
vim.keymap.set("v", "<leader>tr", "<Cmd>Translate W<CR>", { desc = "Translate selection" })

-- treesj
vim.keymap.set("n", "gS", "<Cmd>TSJToggle<CR>", { desc = "Toggle Split/Join" })

-- trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle diagnostics in Trouble" })

-- ufo
vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open All Folds" })
vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close All Folds" })

-- conform
vim.keymap.set("n", "==", function()
  require("conform").format({
    async = false,
    lsp_fallback = true,
    stop_after_first = true,
  })
end, { desc = "Format buffer (language formatter)" })

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    require("conform").format({
      bufnr = args.buf,
      async = false,
      stop_after_first = true,
      lsp_fallback = true,
    })
  end,
})

-- submode
vim.keymap.set({"n","i"}, "<C-r>",function ()
  require("config.run_sm_conf").run_for_ft()
end, { desc = "Run current file" })

vim.keymap.set({"n","i"}, "<C-m>",function ()
  require("config.md_sm_conf").enable_markdown_mode()
end, { desc = "Enter Markdown Submode" })