require("diffview").setup({
    diff_binaries = false,            -- バイナリファイルの差分を表示するか
    enhanced_diff_hl = true,           -- 差分のハイライトを強化 (行内差分など)
    use_icons = true,                  -- ファイルアイコンを使う (web-devicons 必要)
    show_help_hints = true,             -- ヘルプ表示を出すか
    watch_index = true,                -- Git インデックスの変化を監視して自動リフレッシュ

    icons = {
        folder_closed = "",
        folder_open = "",
    },

    signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
    },

    view = {
        default = {
            -- デフォルト差分ビュー時のレイアウト
            layout = "diff2_horizontal",  -- 横分割差分 (`diff2_horizontal` などが指定可能)
        },
        merge_tool = {
            -- マージ (コンフリクト時) 用ビュー
            layout = "diff3_horizontal",  -- ３ウィンドウ (ベース・自分・マージ元)
            disable_dirs = false,         -- ディレクトリをリストに出すか
        },
        file_history = {
            -- ファイル履歴 (ログ) 見るときのビュー
            layout = "diff2_vertical",
        },
    },

    file_panel = {
        listing_style = "tree",
        tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
        },
        win_config = {
            position = "left",   -- 左にパネルを出す
            width = 35,          -- 幅を 35 に指定
            win_opts = {},       -- 追加のウィンドウオプション (もしあれば)
        },
    },

    file_history_panel = {
        log_options = {
            git = {
                single_file = {
                    diff_merges = "combined",
                },
                multi_file = {
                    diff_merges = "first-parent",
                },
            },
        },
        win_config = {
            position = "bottom", -- 履歴パネルを下に出す
            height = 16,         -- 高さを 16 に指定
            win_opts = {},
        },
    },

    -- もし commit_log_panel なども使うなら同様に
    commit_log_panel = {
        win_config = {
            -- 設定例
            position = "bottom",
            height = 16,
            win_opts = {},
        },
    }, 

    key_bindings = {
        -- デフォルトキーをオーバーライド / 追加できる
        view = {
            ["<tab>"] = "select_next_entry",
            ["<s-tab>"] = "select_prev_entry",
            ["gf"] = "goto_file",  -- ファイルを開く
        },
        file_panel = {
            ["j"] = "next_entry",
            ["k"] = "prev_entry",
            ["<cr>"] = "select_entry",
            ["o"] = "toggle_flatten",  -- フォルダーをフラット表示に切り替え
            ["R"] = "refresh_files",   -- リフレッシュ
            ["<c-u>"] = "scroll_view(-0.25)",  -- スクロール
            ["<c-d>"] = "scroll_view(0.25)",
        },
        file_history_panel = {
            ["g!"] = "toggle_full_history",
            ["<cr>"] = "select_entry",
            ["y"] = "copy_hash",
            ["zR"] = "open_all_folds",
            ["zM"] = "close_all_folds",
        },
        option_panel = {
            ["<tab>"] = "select",
            ["q"] = "close",
        },
    },
})