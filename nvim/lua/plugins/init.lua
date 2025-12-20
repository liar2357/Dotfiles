-- lua/plugins/init.lua
return {

  require("plugins.noice"),
  require("plugins.dashboard"),
  require("plugins.playground"),
  require("plugins.ts_text_obj"),
  require("plugins.treesitter"),
  require("plugins.hlchunk"),
  require("plugins.barbar"),
  require("plugins.lua_line"),
  require("plugins.nvim_tree"),
  require("plugins.toggle_term"),
  require("plugins.lazy_git"),
  require("plugins.git_sign"),
  require("plugins.diff_view"),

  -- 「プラグインを追加したらここに続けて記述」
}