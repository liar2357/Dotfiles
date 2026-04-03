local wezterm = require("wezterm")
local M = {}

function M.apply(config)
  local act = wezterm.action

  -- Leaderキー（tmux風）
  config.leader = { key = "/", mods = "CTRL", timeout_milliseconds = 1000 }

  config.keys = {

    -- =====================
    -- タブ操作
    -- =====================
    {
      key = "c",
      mods = "LEADER",
      action = act.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = "x",
      mods = "LEADER",
      action = act.CloseCurrentTab({ confirm = true }),
    },
    {
      key = "n",
      mods = "LEADER",
      action = act.ActivateTabRelative(1),
    },
    {
      key = "p",
      mods = "LEADER",
      action = act.ActivateTabRelative(-1),
    },

    -- =====================
    -- ペイン分割
    -- =====================
    {
      key = "-",
      mods = "LEADER",
      action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "|",
      mods = "LEADER|SHIFT",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },

    -- =====================
    -- ペイン移動（Vim風）
    -- =====================
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

    -- =====================
    -- ペインサイズ変更
    -- =====================
    {
      key = "H",
      mods = "LEADER|SHIFT",
      action = act.AdjustPaneSize({ "Left", 5 }),
    },
    {
      key = "L",
      mods = "LEADER|SHIFT",
      action = act.AdjustPaneSize({ "Right", 5 }),
    },
    {
      key = "K",
      mods = "LEADER|SHIFT",
      action = act.AdjustPaneSize({ "Up", 5 }),
    },
    {
      key = "J",
      mods = "LEADER|SHIFT",
      action = act.AdjustPaneSize({ "Down", 5 }),
    },

    -- =====================
    -- ペイン操作
    -- =====================
    {
      key = "z",
      mods = "LEADER",
      action = act.TogglePaneZoomState,
    },

    -- =====================
    -- コピー・検索
    -- =====================
    {
      key = "y",
      mods = "LEADER",
      action = act.ActivateCopyMode,
    },
    {
      key = "/",
      mods = "LEADER",
      action = act.Search("CurrentSelectionOrEmptyString"),
    },

    -- =====================
    -- コマンドパレット
    -- =====================
    {
      key = "p",
      mods = "CTRL|SHIFT",
      action = act.ActivateCommandPalette,
    },

    -- =====================
    -- フルスクリーン
    -- =====================
    {
      key = "Enter",
      mods = "ALT",
      action = act.ToggleFullScreen,
    },

    -- =====================
    -- フォントサイズ
    -- =====================
    {
      key = "+",
      mods = "CTRL",
      action = act.IncreaseFontSize,
    },
    {
      key = "-",
      mods = "CTRL",
      action = act.DecreaseFontSize,
    },
    {
      key = "0",
      mods = "CTRL",
      action = act.ResetFontSize,
    },
  }

  -- =====================
  -- リサイズモード（上級）
  -- =====================
  config.key_tables = {
    resize_mode = {
      { key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
      { key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
      { key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
      { key = "Escape", action = "PopKeyTable" },
    },
  }

  table.insert(config.keys, {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "resize_mode",
      one_shot = false,
    }),
  })
end

return M
