return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      -- ファイルタイプ → フォーマッタ名
      formatters_by_ft = {
        rust = { "rustfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
        mdx = { "prettier" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        cs = { "csharpier" },
        java = { "google-java-format" },
        php = { "php_cs_fixer" },
        ruby = { "rubocop" },
        python = { "black" },
        sh = { "shfmt" },
        sql = { "sqruff" },
        nix = { "nixfmt" },
        lua = { "stylua" },
        xml = { "xmllint" },
        toml = { "taplo" },
      },

      -- フォーマッタの詳細定義
      formatters = {
        stylua = {
          command = "stylua",
          args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
            "-",
          },
          stdin = true,
        },
        xmllint = {
          command = "xmllint",
          args = { "--format", "-" },
          stdin = true,
        },
        taplo = {
          command = "taplo",
          args = { "fmt", "-" },
          stdin = true,
        },
        php_cs_fixer = {
          command = "php-cs-fixer",
          args = {
            "fix",
            "$FILENAME",
            "--quiet",
          },
          stdin = false,
        },
      },

      format_on_save = {
        timeout_ms = 10000,
        lsp_fallback = true,
      },
    })
  end,
}
