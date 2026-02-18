return{
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "mason.nvim", "none-ls.nvim" },
    config = function()
        require("mason-null-ls").setup({
            -- mason で ensure_installed を指定
            ensure_installed = { "prettierd", "eslint_d" },
            automatic_setup = false,  -- 自動セットアップをオフに
        })
    end,
}