local dashboard = require("dashboard")

-- 任意のアスキーアート（ロゴ）を設定
local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]
dashboard.setup({
    theme = "hyper",  -- 既存のテーマが “hyper” ならそのまま
    config = {
        header = vim.split(logo, "\n"),
        shortcut = {
            { desc = 'New File', key = 'n', action = 'enew' },
            { desc = 'Find File', key = 'f', action = 'Telescope find_files' },
            { desc = 'Projects', key = 'p', action = 'Telescope projects' },
            { desc = 'Quit', key = 'q', action = 'qa' },
        },
    },
})
