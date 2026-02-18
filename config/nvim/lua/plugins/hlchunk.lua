-- hlchunk.nvim 
return{
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("hlchunk").setup({

      chunk = {
        style = {
            { fg = "#806d9c" },
            { fg = "#c21f30" },
        },
        use_treesitter = true,
        chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
        },
        textobject = "",
        max_file_size = 1024 * 1024,
        error_sign = true,
        -- animation related
        duration = 100,
        delay = 100,
        enable = true,
        notify = false,
        priority = 100,               -- 優先度を比較的高く
        exclude_filetypes = {
          "dashboard", "NvimTree",    -- あなたの環境に合わせて
        },
      },
      indent = {
        enable = true,
        chars = {
          "│"
        },
        style = {
          "#FF0000",
          "#FF7F00",
          "#FFFF00",
          "#00FF00",
          "#00FFFF",
          "#0000FF",
          "#8B00FF",
        },
        exclude_filetypes = {
          "dashboard", "NvimTree",
        },
      },
      -- 他モード（blank, line_num）を使わないなら無効化
      blank = { enable = false },
      line_num = { enable = false },
    })
  end,
}