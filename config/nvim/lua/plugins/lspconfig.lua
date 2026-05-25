return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    -- 共通 keybind
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
        vim.keymap.set("n", "<C-i>", vim.lsp.buf.hover, { buffer = bufnr })
      end,
    })

    local is_windows = vim.fn.has("win32") == 1

    -- Rust
    vim.lsp.config.rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            command = "clippy",
          },
          procMacro = {
            enable = true,
          },
        },
      },
    }
    vim.lsp.enable({ "rust_analyzer" })

    -- TS/JS
    vim.lsp.config.ts_ls = {}
    vim.lsp.enable({ "ts_ls" })

    -- C/C++
    vim.lsp.config.clangd = {}
    vim.lsp.enable({ "clangd" })

    -- 他の言語も同様に
    vim.lsp.config.pyright = {}
    vim.lsp.enable({ "pyright" })

    vim.lsp.config.bashls = {}
    vim.lsp.enable({ "bashls" })

    vim.lsp.config.html = {}
    vim.lsp.enable({ "html" })

    vim.lsp.config.cssls = {}
    vim.lsp.enable({ "cssls" })

    vim.lsp.config.jdtls = {}
    vim.lsp.enable({ "jdtls" })

    vim.lsp.config.php = is_windows and {
      name = "intelephense",
      cmd = { "intelephense", "--stdio" },
    } or {
      name = "phpactor",
      cmd = { "phpactor", "language-server" },
    }

    vim.lsp.enable({ "php" })

    vim.lsp.config.solargraph = {}
    vim.lsp.enable({ "solargraph" })

    vim.lsp.config.sqlls = is_windows
        and {
          name = "sql-language-server",
          cmd = {
            "sql-language-server",
            "up",
            "--method",
            "stdio",
          },
        }
      or {
        name = "sqls",
      }

    vim.lsp.enable({ "sqlls" })

    vim.lsp.config.nixd = {
      cmd = { "nixd" },
      filetypes = { "nix" },
      settings = {
        nixd = {
          nixpkgs = {
            expr = "import <nixpkgs> { }",
          },
          formatting = {
            command = { "nixfmt" },
          },
        },
      },
    }
    vim.lsp.enable({ "nixd" })

    vim.lsp.config.taplo = {}
    vim.lsp.enable({ "taplo" })

    vim.lsp.config.lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT", -- Neovim用
          },
          diagnostics = {
            globals = { "vim" }, -- これ重要
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
          format = {
            enable = false,
          },
        },
      },
    }
    vim.lsp.enable({ "lua_ls" })
  end,
}
