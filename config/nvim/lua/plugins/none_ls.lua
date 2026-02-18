return{
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        -- 正しく require するのは null-ls
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- 例：styLua をフォーマッタとして使う
                null_ls.builtins.formatting.stylua,
            },
        })
    end,
}