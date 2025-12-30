return{
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ts_ls","clangd","html","cssls","pyright","bashls","phpactor","solargraph","sqls","jdtls","prettier","clang-format","csharpier","google-java-format","php-cs-fixer","rubocop","black","shfmt","sqruff","sql-formatter"
            },
        })
    end,
}