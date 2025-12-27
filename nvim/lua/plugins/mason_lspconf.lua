return{
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer","ts_ls","clangd","html","cssls","pyright","bashls","phpactor","solargraph","jdtls"
            },
        })
    end,
}