-- Hyprland Lua Configuration
-- https://wiki.hypr.land/Configuring/

-- ENVIRONMENT VARIABLES

-- Private / machine-specific env vars — gitignored, optional.
pcall(require, 'private')

hl.env('XCURSOR_SIZE', '24')
hl.env('HYPRCURSOR_SIZE', '24')
hl.env('XDG_CURRENT_DESKTOP', 'Hyprland')

-- Nvidia fixes
hl.env('LIBVA_DRIVER_NAME', 'nvidia')
hl.env('__GLX_VENDOR_LIBRARY_NAME', 'nvidia')
hl.env('ELECTRON_OZONE_PLATFORM_HINT', 'auto')
hl.env('NVD_BACKEND', 'direct')

-- SOURCE CONFIGS
require 'conf.autostart'
require 'conf.appearance'
require 'conf.input'
require 'conf.keybinds'
require 'conf.rules'
