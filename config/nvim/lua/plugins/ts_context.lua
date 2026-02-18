return{
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPre", -- 適宜遅延読み込み
    config = function()
        require("treesitter-context").setup({
            mode = "cursor",   -- カーソル位置のコンテキストを表示
            max_lines = 3,
        })
    end,
}