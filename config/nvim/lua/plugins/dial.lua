return{
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.date.alias["%Y/%m/%d"],
                augend.constant.alias.bool,
            },
        })
    end,
}