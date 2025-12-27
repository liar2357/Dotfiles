return{
    "LudoPinelli/comment-box.nvim",
    cmd = { "CBline", "CBbox" }, -- コマンド起動
    keys = {
        { "<Leader>cb", "<Cmd>CBbox<CR>", desc = "Comment Box" },
        { "<Leader>cl", "<Cmd>CBline<CR>", desc = "Comment Line" },
    },
    config = function()
        -- 特別設定不要なケースが多いです
    end,
}