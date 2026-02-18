return {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    dependencies = { "kevinhwang91/nvim-hlslens", "lewis6991/gitsigns.nvim" },
    config = function()
        require("scrollbar").setup({})
    end,
}