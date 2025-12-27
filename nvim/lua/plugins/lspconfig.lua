return {
  "neovim/nvim-lspconfig",
  config = function()
    -- LSP を attach したときのキーマップ
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local map = vim.keymap.set
        map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
        map("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
        map("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
      end,
    })

    -- Rust Analyzer を有効化
    vim.lsp.config("rust_analyzer", {
      -- 必要なら追加設定をここに
      settings = {
        ["rust-analyzer"] = {
          rustfmt = {
            enabled = true,
          }
        },
      },
    })
    vim.lsp.enable("rust_analyzer")

    -- ts_ls  (tsserver の新名称)
    vim.lsp.config("ts_ls", {})
    vim.lsp.enable("ts_ls")

    -- その他の LSP も同様
    vim.lsp.config("clangd", {})
    vim.lsp.enable("clangd")

    vim.lsp.config("pyright", {})
    vim.lsp.enable("pyright")

    vim.lsp.config("bashls", {})
    vim.lsp.enable("bashls")

    vim.lsp.config("html", {})
    vim.lsp.enable("html")

    vim.lsp.config("cssls", {})
    vim.lsp.enable("cssls")

    vim.lsp.config("jdtls", {})
    vim.lsp.enable("jdtls")

    vim.lsp.config("phpactor", {})
    vim.lsp.enable("phpactor")

    vim.lsp.config("solargraph", {})
    vim.lsp.enable("solargraph")
  end,
}