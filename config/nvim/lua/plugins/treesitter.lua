return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter").install({
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
        "json",
        "jsonc",
        "toml",
        "yaml",
        "xml",
        "bash",
        "markdown",
        "markdown_inline",
        "tsx",
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
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
          "json",
          "jsonc",
          "toml",
          "yaml",
          "xml",
          "bash",
          "markdown",
          "markdown_inline",
          "tsx",
        },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
  },
}
