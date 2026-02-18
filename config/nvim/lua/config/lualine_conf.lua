local function selection_count()
  local mode = vim.fn.mode()
  local start_line, end_line, start_pos, end_pos

  -- 選択モードでない場合には無効
  if not (mode:find("[vV\22]") ~= nil) then return "" end
  start_line = vim.fn.line("v")
  end_line = vim.fn.line(".")

  if mode == 'V' then
    -- 行選択モードの場合は、各行全体をカウントする
    start_pos = 1
    end_pos = vim.fn.strlen(vim.fn.getline(end_line)) + 1
  else
    start_pos = vim.fn.col("v")
    end_pos = vim.fn.col(".")
  end

  local chars = 0
  for i = start_line, end_line do
    local line = vim.fn.getline(i)
    local line_len = vim.fn.strlen(line)
    local s_pos = (i == start_line) and start_pos or 1
    local e_pos = (i == end_line) and end_pos or line_len + 1
    chars = chars + vim.fn.strchars(line:sub(s_pos, e_pos - 1))
  end

  local lines = math.abs(end_line - start_line) + 1
  return tostring(lines) .. " lines, " .. tostring(chars) .. " characters"
end

local custom_cs = {
  normal = {
    a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
    b = { fg = '#cccccc', bg = '#111111' },
    c = { fg = '#aaaaaa', bg = '#222222' },
  },
  insert = {
    a = { fg = '#000000', bg = '#8080ff', gui = 'bold' },
  },
  visual = {
    a = { fg = '#000000', bg = '#ff8000', gui = 'bold' },
  },
  replace = {
    a = { fg = '#000000', bg = '#ff8080', gui = 'bold' },
  },
  command = { 
    a = { fg = '#000000', bg = '#80ff80', gui = 'bold' },
  },
  terminal = { 
  a = { fg = '#000000', bg = '#80ff80', gui = 'bold' },
},
  inactive = {
    a = { fg = '#888888', bg = '#111111', gui = 'bold' },
    c = { fg = '#555555', bg = '#111111' },
  },
}

local submode_comp = require("config.lualine_submode")

require('lualine').setup {
options = {
  icons_enabled = true,
  theme = custom_cs,
  component_separators = { left = '', right = ''},
  section_separators = { left = '', right = ''},
  disabled_filetypes = {
    statusline = {},
    winbar = {},
  },
  ignore_focus = {},
  always_divide_middle = true,
  always_show_tabline = true,
  globalstatus = true,
  refresh = {
    statusline = 1000,
    tabline = 1000,
    winbar = 1000,
    refresh_time = 16, -- ~60fps
    events = {
      'WinEnter',
      'BufEnter',
      'BufWritePost',
      'SessionLoadPost',
      'FileChangedShellPost',
      'VimResized',
      'Filetype',
      'CursorMoved',
      'CursorMovedI',
      'ModeChanged',
    },
  }
},
sections = {
  lualine_a = {submode_comp.mode_or_submode,},
  lualine_b = {'branch', 'diff', 'diagnostics'},
  lualine_c = {'filename'},
  lualine_x = {selection_count,'encoding', 'fileformat', 'filetype'},
  lualine_y = {'progress'},
  lualine_z = {'location'}
},
inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {'filename'},
  lualine_x = {'location'},
  lualine_y = {},
  lualine_z = {}
},
tabline = {},
winbar = {},
inactive_winbar = {},
extensions = {}
}