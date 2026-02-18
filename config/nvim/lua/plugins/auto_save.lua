return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle",            -- キーでもロードされる
  event = { "InsertLeave", "TextChanged" },
  config = function()
    require("auto-save").setup({
      enabled = true,          -- 起動時に自動保存有効
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save     = { "InsertLeave", "TextChanged" },
        cancel_deferred_save = { "InsertEnter" },
      },
      debounce_delay = 1000,
    })
  end,
}