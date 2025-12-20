return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview: Open diff" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: File history" },
        { "<leader>gC", "<cmd>DiffviewClose<CR>", desc = "Diffview: Close" },
    },
}