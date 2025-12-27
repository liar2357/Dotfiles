return{
    "bassamsdata/namu.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("namu").setup()
    end,
}