return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- グローバル変数でオプションを設定
    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 0.9
    vim.g.lazygit_floating_window_border_chars = { '╭','─','╮','│','╯','─','╰','│' }
    vim.g.lazygit_use_neovim_remote = 0  -- PowerShell などでネイティブ nvr がないなら無効にする
    -- コールバック（必要があれば）
    vim.g.lazygit_on_exit_callback = function()
      -- Lazygit を閉じたあとにやりたい操作を書く
    end
  end,
}