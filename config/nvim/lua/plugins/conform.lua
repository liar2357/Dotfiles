return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      -- ファイルタイプ → フォーマッタ名
      formatters_by_ft = {
        -- Rust
        rust = { "rustfmt" },

        -- JS / TS / React / JSON / CSS / HTML / Markdown
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },

        -- C / C++
        c = { "clang-format" },
        cpp = { "clang-format" },

        -- C#
        cs = { "csharpier" },

        -- Java
        java = { "google-java-format" },

        -- PHP
        php = { "php-cs-fixer" },

        -- Ruby
        ruby = { "rubocop" },

        -- Python
        python = { "black" },

        -- Bash
        sh = { "shfmt" },
        
        -- SQl
        sql = { "sqruff", "sql-formatter" },
      },

      -- フォーマッタの詳細定義
      formatters = {
        rustfmt = {
          command = "rustfmt",
          stdin = true,
        },
      },

      format_on_save = false,
    })
  end,
}