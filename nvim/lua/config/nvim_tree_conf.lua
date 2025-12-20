require("nvim-tree").setup({
  -- 基本ビュー設定
  view = {
    width = 30,            -- ファイルツリーの幅
    side = "left",         -- 左側に表示
    number = false,        -- 行番号を表示しない
    relativenumber = false,
    adaptive_size = false, -- 自動でサイズを変えない
  },

  -- レンダリング（見た目）設定
  renderer = {
    group_empty = true,    -- 空のディレクトリをグループ化
    highlight_git = true,  -- Git の状態を強調表示
    icons = {
      webdev_colors = true,
      git_placement = "signcolumn",
      padding = " ", -- アイコンと名前の間のスペース
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },

  -- Git 統合の設定
  git = {
    enable = true,
    ignore = false,       -- .gitignore を無視しない
    timeout = 500,
  },

  -- フィルタ（表示・非表示設定）
  filters = {
    dotfiles = false,     -- ドットファイルを表示するかどうか
    custom = { ".cache", "node_modules" }, -- 任意のディレクトリを非表示に
  },

  -- ファイル操作の設定
  actions = {
    open_file = {
      quit_on_open = false,  -- ファイルを開いたときにツリーを閉じない
    },
    remove_file = {
      close_window = true,   -- ファイルを削除したらウィンドウを閉じる
    },
  },

  -- 更新・リフレッシュの設定
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },

  -- その他
  update_focused_file = {
    enable = true,           -- 現在開いているファイルの位置をツリーと同期
    update_cwd = true,       -- カレントディレクトリをツリーと同期
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  system_open = {
    cmd = nil,                -- デフォルトのシステムコマンドを使う
    args = {},
  },
})