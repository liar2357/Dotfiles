--##################
--## WINDOW RULE ###
--##################

-- Konsole
hl.window_rule({
  match = {
    class = "^Konsole|org.kde.konsole$",
  },
  opacity = "0.9 override 0.85 override",
})

-- kitty
hl.window_rule({
  match = {
    class = "^kitty$",
  },
  opacity = "0.9 override 0.85 override",
})

-- VSCode / VSCodium
hl.window_rule({
  match = {
    class = "^code|Code|VSCodium$",
  },
  opacity = "0.9 override 0.85 override",
})

-- kitty NotifyCenter
hl.window_rule({
  match = {
    title = "^NotifyCenter$",
  },
  float = true,
  size = "720 480",
  center = true,
  opacity = "0.9 override",
})

-- emu-board
hl.layer_rule({
  match = {
    namespace = "^emu-board$",
  },
  above_lock = 2,
})
