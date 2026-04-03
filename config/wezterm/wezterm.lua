local wezterm = require("wezterm")

local config = {}

-- 分割読み込み
local system = require("modules.system")
local fonsts = require("modules.fonts")
local keys = require("modules.keys")

-- マージ
config = wezterm.config_builder()

system.apply(config)
fonsts.apply(config)
keys.apply(config)

return config
