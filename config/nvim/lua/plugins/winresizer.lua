return{
    "simeji/winresizer",
    keys = { { "<Leader>wr", "<Cmd>WinResizerStartResize<CR>", desc = "Resize Window" } },
    config = function()
        vim.g.winresizer_start_key = "<Leader>wr"
    end,
}