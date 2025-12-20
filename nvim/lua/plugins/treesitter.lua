
return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- NOTE: master を使うのが安定、main でも動くけど README では推奨されている
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects"
    },
    -- ここで module を明示する
    module = "nvim-treesitter.configs",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "rust",
          "python",
          "javascript",
          "typescript",
          "html",
          "css",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
}