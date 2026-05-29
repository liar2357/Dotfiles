return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    -- ここで module を明示する
    module = "nvim-treesitter.configs",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = false,
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
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
            },
          },
        },
      })
    end,
  },
}
