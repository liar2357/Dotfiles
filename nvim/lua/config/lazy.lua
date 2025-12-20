-- lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- リーダーキー（好みで）を設定
vim.g.mapleader = " "        -- スペースをリーダーに
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    -- プラグイン定義の読み込み
    require("plugins.init"),
  },
  checker = { enabled = true },  -- 更新チェックを有効化（任意）
  -- 他オプションあれば追加可能
})

vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  callback = function()
    local ft = vim.bo.filetype
    local has_parser = #vim.treesitter.get_parser(0, ft, { error = false }) > 0
    if has_parser then
      -- parserが有れば start
      vim.treesitter.start(0, ft)
    end
  end,
})
