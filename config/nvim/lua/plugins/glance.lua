return{
    "dnlhc/glance.nvim",
    cmd = "Glance", -- 必要な時だけ読み込む
    config = function()
        require("glance").setup({
            height = 18,
            list = { position = "right", width = 0.33 },
        })
    end,
}