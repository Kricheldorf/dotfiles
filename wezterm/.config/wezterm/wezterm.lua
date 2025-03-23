local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("MonoLisa-Regular")
config.color_scheme = "Dracula"
config.unix_domains = {
	{
		name = "unix",
	},
}

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.
config.default_gui_startup_args = { "connect", "unix" }

return config
