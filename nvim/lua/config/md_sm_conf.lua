-- lua/config/submode_conf.lua
local sm = require("nvim-submode")
local md = require("config.markdown_utils")

local function notify_desc(desc)
    if desc then
        vim.notify(desc, vim.log.levels.INFO, { title = "Markdown Mode" })
    end
end

local markdown_mode = sm.build_submode(
    { name = "Markdown", timeoutlen = 200,is_count_enable = false, },
    {
        { "b",function ()
            notify_desc("Bold")
            md.bold()
        end, { desc = "Bold" } },
        { "i", function ()
            notify_desc("Italic")
            md.italic()
        end, { desc = "Italic" } },
        { "-",function ()
            notify_desc("Strikethrough")
            md.strikethrough()
        end, { desc = "Strikethrough" } },
        { "h",function ()
            notify_desc("horizontal Rule")
            md.horizontal_rule()
        end, { desc = "Horizontal Rule" } },
        { "#", function ()
            notify_desc("Comment (HTML)" )
            md.comment()
        end, { desc = "Comment (HTML)" } },
        { "q", function ()
            notify_desc("Blockquote" )
            md.quote()
        end, { desc = "Blockquote" } },
        { "u", function ()
            notify_desc("Unordered List" )
            md.unordered_list()
        end, { desc = "Unordered List" } },
        { "o", function ()
            notify_desc("Ordered List" )
            md.ordered_list()
        end, { desc = "Ordered List" } },
        { "p", function ()
            notify_desc("Insert Image" )
            md.insert_image()
        end, { desc = "Insert Image" } },
        { "t", function ()
            notify_desc("Insert Table" )
            md.insert_table()
        end, { desc = "Insert Table" } },
        { "k", function ()
            notify_desc("Code Block" )
            md.insert_codeblock()
        end, { desc = "Code Block" } },
        { "c", function ()
            notify_desc("Toggle Checkbox" )
            md.toggle_checkbox()
        end, { desc = "Toggle Checkbox" } },
        { "1", function ()
            notify_desc("H1" )
            md.H1()
        end, { desc = "H1" } },
        { "2", function ()
            notify_desc("H2" )
            md.H2()
        end, { desc = "H2" } },
        { "3", function ()
            notify_desc("H3" )
            md.H3()
        end, { desc = "H3" } },
        { "l", function ()
            notify_desc("Insert Link" )
            md.link_template()
        end, { desc = "Insert Link" } },
        { "jk", function()
            notify_desc("Exit Markdown Mode" )
            return "", sm.EXIT_SUBMODE
        end, { desc = "Exit Markdown Mode" } },
        { "<Esc>", function()
            notify_desc("Exit Markdown Mode" )
            return "", sm.EXIT_SUBMODE
        end, { desc = "Exit Markdown Mode" } },
    }
)

function markdown_mode.enable()
    notify_desc("Enter Markdown Mode" )
    sm.enable(markdown_mode)
end

return {
    enable_markdown_mode = markdown_mode.enable
}
