return{
    "OXY2DEV/markview.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    ft = { "markdown", "typst", "latex", "html", "yaml" },
    config = function()
        require("markview").setup({
            preview = {
                icon_provider = "internal",
            },
        })
    end,
}