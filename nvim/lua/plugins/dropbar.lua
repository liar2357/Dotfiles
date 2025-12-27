return{
    "Bekaboo/dropbar.nvim",
    dependencies = { "nvim-web-devicons" }, -- アイコン optional
    event = "BufWinEnter",
    config = function()
        require("dropbar").setup({})
    end,
}