local is_nixos = vim.fn.filereadable("/etc/NIXOS") == 1

if is_nixos then
  return {}
end

return{
    "williamboman/mason-lspconfig.nvim",
    enabled = not vim.loop.os_uname().sysname:match("NixOS"),
    dependencies = { "mason.nvim" },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ts_ls","clangd","html","cssls","pyright","bashls","phpactor","solargraph","sqls","jdtls","prettier","clang-format","csharpier","google-java-format","php-cs-fixer","rubocop","black","shfmt","sqruff","sql-formatter"
            },
        })
    end,
}
