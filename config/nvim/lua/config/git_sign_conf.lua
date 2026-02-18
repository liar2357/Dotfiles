require("gitsigns").setup({
  signs = {
    add          = { text = "│" },
    change       = { text = "│" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  -- Git blame の設定
  current_line_blame = true,            -- 現在の行の blame 情報を仮想テキストで表示
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",               -- 行末 (end-of-line) に表示
    delay = 500,                         -- 遅延 (ミリ秒)
    ignore_whitespace = false,
  },
  -- word diff (単語レベル差分) を有効にするか
  word_diff = false,

  -- hunk を監視する Git ディレクトリ設定
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },

  -- サインの優先度 (他の sign と重なったときの優先順位)
  sign_priority = 6,

  -- 大きいファイルでは gitsigns を無効化 (パフォーマンス対策)
  max_file_length = 40000,  -- 行数の上限 (この例では 40000 行)

  -- プレビュー設定 (hunk プレビューウィンドウ)
  preview_config = {
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
    border = "single",
  },

  -- 各種アクション用の on_attach コールバック (キーマップ設定など)
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- ナビゲーション
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd("normal ]c")
      else
        gs.next_hunk()
      end
    end, { desc = "Next Git hunk" })

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd("normal [c")
      else
        gs.prev_hunk()
      end
    end, { desc = "Previous Git hunk" })

    -- ステージ / リセット
    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
    map("v", "<leader>hs", function()
      gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
    end, { desc = "Stage hunk (visual)" })
    map("v", "<leader>hr", function()
      gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
    end, { desc = "Reset hunk (visual)" })

    -- プレビュー
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

    -- Blame トグル
    map("n", "<leader>hb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })

    -- 差分を Quickfix リスト or Loclist に出す
    map("n", "<leader>hq", gs.setqflist, { desc = "Set QF list for git hunks" })
    map("n", "<leader>hl", gs.setloclist, { desc = "Set Loc list for git hunks" })

    -- テキストオブジェクト (hunk) 選択
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Git hunk" })
  end,
})