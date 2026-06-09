-- KEYBINDINGS

local helpers = require 'conf.helpers'

local main_mod = 'SUPER'
local terminal = 'kitty'
local menu = 'vicinae toggle'
local clipboard_manager = 'vicinae vicinae://launch/clipboard/history'
local headphones_id = 'F8:4E:17:7D:27:31'
local screenshot_region_cmd = 'hyprshot -r -z -m region | satty -f - -o png'
local screenshot_window_cmd = 'hyprshot -r -z -m window -m active | wl-copy'

-- Reload Hyprland config and vicinae server
hl.bind(main_mod .. ' + CTRL + SHIFT + R', hl.dsp.exec_cmd 'hyprctl reload && killall vicinae; vicinae server &')

-- Minimize window to special workspace
hl.bind(main_mod .. ' + M', helpers.minimize_to_special 'minimized')
hl.bind(main_mod .. ' + CTRL + M', helpers.minimize_to_special 'ctrl-minimized')

hl.bind(main_mod .. ' + Return', hl.dsp.exec_cmd(terminal))

-- Master/dwindle layout binds for X
hl.bind(main_mod .. ' + X', helpers.layout_msg('swapwithmaster', 'swapsplit'))
hl.bind(main_mod .. ' + SHIFT + X', helpers.layout_msg('orientationcycle left top center', 'togglesplit'))

hl.bind(main_mod .. ' + Q', hl.dsp.window.close())
hl.bind(main_mod .. ' + SHIFT + V', hl.dsp.window.float { action = 'toggle' })
hl.bind(main_mod .. ' + Space', hl.dsp.exec_cmd(menu))

-- Move focus
hl.bind(main_mod .. ' + H', hl.dsp.focus { direction = 'left' })
hl.bind(main_mod .. ' + L', hl.dsp.focus { direction = 'right' })
hl.bind(main_mod .. ' + K', hl.dsp.focus { direction = 'up' })
hl.bind(main_mod .. ' + J', hl.dsp.focus { direction = 'down' })

-- Workspaces 1-10
for i = 1, 10 do
  local key = i % 10
  hl.bind(main_mod .. ' + ' .. key, helpers.go_to_workspace(i))
  hl.bind(main_mod .. ' + SHIFT + ' .. key, hl.dsp.window.move { workspace = i, silent = true })
end

-- Special workspaces
hl.bind(main_mod .. ' + S', hl.dsp.workspace.toggle_special 'magic')
hl.bind(main_mod .. ' + SHIFT + S', hl.dsp.window.move { workspace = 'special:magic' })
hl.bind(main_mod .. ' + G', hl.dsp.workspace.toggle_special 'lazygit')
hl.bind(main_mod .. ' + SHIFT + G', hl.dsp.window.move { workspace = 'special:lazygit' })
hl.bind(main_mod .. ' + grave', hl.dsp.workspace.toggle_special 'terminal')
hl.bind(main_mod .. ' + SHIFT + grave', hl.dsp.window.move { workspace = 'special:terminal' })
hl.bind(main_mod .. ' + A', hl.dsp.workspace.toggle_special 'agent')
hl.bind(main_mod .. ' + SHIFT + A', hl.dsp.window.move { workspace = 'special:agent' })

hl.bind(main_mod .. ' + SHIFT + CTRL + C', hl.dsp.exec_cmd(terminal .. " --hold -d ~/dotfiles/ fish -c 'nvim ~/.config/hypr/hyprland.lua'"))
hl.bind(main_mod .. ' + SHIFT + CTRL + T', hl.dsp.exec_cmd(terminal .. " fish -c 'track edit'"))

hl.bind(main_mod .. ' + SHIFT + B', hl.dsp.exec_cmd 'pkill -SIGUSR1 waybar')

-- Scroll through workspaces
hl.bind(main_mod .. ' + mouse_down', hl.dsp.focus { workspace = 'e+1' })
hl.bind(main_mod .. ' + mouse_up', hl.dsp.focus { workspace = 'e-1' })

-- Mouse drag/resize
hl.bind(main_mod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })
hl.bind(main_mod .. ' + SHIFT + mouse:272', hl.dsp.window.resize(), { mouse = true })

-- Volume / brightness
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd 'wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+', { locked = true, repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-', { locked = true, repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_cmd 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle', { locked = true, repeating = true })
hl.bind('XF86AudioMicMute', hl.dsp.exec_cmd 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle', { locked = true, repeating = true })
hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd 'brightnessctl -e4 -n2 set 5%+', { locked = true, repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd 'brightnessctl -e4 -n2 set 5%-', { locked = true, repeating = true })

-- playerctl
hl.bind('XF86AudioNext', hl.dsp.exec_cmd 'playerctl next', { locked = true })
hl.bind('XF86AudioPause', hl.dsp.exec_cmd 'playerctl play-pause', { locked = true })
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd 'playerctl play-pause', { locked = true })
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd 'playerctl previous', { locked = true })

-- Screenshot
hl.bind('PRINT', hl.dsp.exec_cmd(screenshot_region_cmd))
hl.bind(main_mod .. ' + CTRL + 4', hl.dsp.exec_cmd(screenshot_region_cmd))
hl.bind(main_mod .. ' + CTRL + 3', hl.dsp.exec_cmd(screenshot_window_cmd))

-- Fullscreen / pin / cycle
hl.bind(main_mod .. ' + F', helpers.toggle_maximize())
hl.bind(main_mod .. ' + SHIFT + F', helpers.toggle_inner_fullscreen())
hl.bind(main_mod .. ' + CTRL + F', helpers.toggle_monocle())
hl.bind(main_mod .. ' + SHIFT + P', hl.dsp.window.pin())
hl.bind(main_mod .. ' + N', hl.dsp.window.cycle_next())
hl.bind(main_mod .. ' + TAB', hl.dsp.exec_cmd 'vicinae vicinae://launch/wm/switch-windows')
hl.bind(main_mod .. ' + P', hl.dsp.window.cycle_next 'prev')

-- Split ratio
hl.bind(main_mod .. ' + ALT + F', hl.dsp.exec_cmd 'hyprctl dispatch splitratio exact 1')
hl.bind(main_mod .. ' + ALT + L', hl.dsp.exec_cmd 'hyprctl dispatch splitratio 1.7')
hl.bind(main_mod .. ' + ALT + H', hl.dsp.exec_cmd 'hyprctl dispatch splitratio -1.7')

-- Resize+center hacks
hl.bind(main_mod .. ' + SHIFT + Return', hl.dsp.exec_cmd 'hyprctl dispatch resizeactive exact 1200 800 && hyprctl dispatch centerwindow')
hl.bind(
  main_mod .. ' + CTRL + C',
  hl.dsp.exec_cmd [[sh -c '[ "$(hyprctl activewindow -j | jq -r .floating)" = "true" ] && { hyprctl dispatch fullscreen && hyprctl dispatch fullscreen && hyprctl dispatch resizeactive exact 1840 1000 && hyprctl dispatch centerwindow && hyprctl dispatch fullscreen && hyprctl dispatch fullscreen && hyprctl dispatch resizeactive exact 1840 1000 && hyprctl dispatch centerwindow; }']]
)

-- Move cursor to top-left corner of window
hl.bind(main_mod .. ' + SHIFT + M', hl.dsp.cursor.move_to_corner { corner = 2 })

-- Groups
hl.bind(main_mod .. ' + T', hl.dsp.group.toggle())
hl.bind(main_mod .. ' + bracketright', hl.dsp.group.next())
hl.bind(main_mod .. ' + bracketleft', hl.dsp.group.prev())
hl.bind(main_mod .. ' + P', hl.dsp.group.prev())
hl.bind(main_mod .. ' + N', hl.dsp.group.next())

-- Move to monitor (no-op if no monitor in that direction, avoids warning)
hl.bind(main_mod .. ' + CTRL + H', helpers.move_to_monitor 'l')
hl.bind(main_mod .. ' + CTRL + J', helpers.move_to_monitor 'd')
hl.bind(main_mod .. ' + CTRL + K', helpers.move_to_monitor 'u')
hl.bind(main_mod .. ' + CTRL + L', helpers.move_to_monitor 'r')

-- Move/swap within layout
hl.bind(main_mod .. ' + SHIFT + H', helpers.move_window('left', 'down'))
hl.bind(main_mod .. ' + SHIFT + L', helpers.move_window('right', 'up'))
hl.bind(main_mod .. ' + SHIFT + K', hl.dsp.window.swap { direction = 'u' })
hl.bind(main_mod .. ' + SHIFT + J', hl.dsp.window.swap { direction = 'd' })
hl.bind(main_mod .. ' + SHIFT + P', hl.dsp.layout 'promote')

hl.bind('CTRL + ALT + Q', helpers.lock_screen())
hl.bind(main_mod .. ' + CTRL + B', hl.dsp.exec_cmd('bluetoothctl connect ' .. headphones_id .. ' && notify-send "Bluetooth" "Device connected"'))

hl.bind(main_mod .. ' + ALT + C', hl.dsp.exec_cmd(clipboard_manager))
hl.bind(main_mod .. ' + V', hl.dsp.exec_cmd '~/scripts/edit-clipboard')

hl.bind(main_mod .. ' + Escape', hl.dsp.exec_cmd(terminal .. " fish -c 'claude'"))
hl.bind(main_mod .. ' + O', helpers.focus_or_launch('nvim-notes', "kitty -d $HOME/GDrive-Personal/dev-notes --class nvim-notes fish -c 'nvim'"))
hl.bind(main_mod .. ' + D', helpers.focus_or_launch('neovim-ide', 'kitty --class neovim-ide fish -c nvim'))
hl.bind(main_mod .. ' + SHIFT + D', hl.dsp.exec_cmd(terminal .. 'fish -c nvim'))
-- hl.bind(main_mod .. ' + SHIFT + D', hl.dsp.exec_cmd [[sh -c 'cd "$DEFAULT_WORK_DIR" && zeditor -e .']])

hl.bind('SUPER + CTRL + tab', hl.dsp.exec_cmd '$HOME/.config/hypr/scripts/cycle-layout.sh') -- Set next layout
hl.bind('SUPER + SHIFT + CTRL + tab', hl.dsp.exec_cmd '$HOME/.config/hypr/scripts/cycle-layout.sh --prev') -- Set previous layout

-- Submaps
hl.define_submap('resize', function()
  hl.bind('H', hl.dsp.window.resize { x = 60, y = 0, relative = true })
  hl.bind('L', hl.dsp.window.resize { x = -60, y = 0, relative = true })
  hl.bind('K', hl.dsp.window.resize { x = 0, y = -60, relative = true })
  hl.bind('J', hl.dsp.window.resize { x = 0, y = 60, relative = true })
  hl.bind('Return', hl.dsp.submap 'reset')
  hl.bind('Escape', hl.dsp.submap 'reset')
  hl.bind('catchall', hl.dsp.submap 'resize')
end)
hl.bind(main_mod .. ' + SHIFT + R', hl.dsp.submap 'resize')

hl.define_submap('launch', 'reset', function()
  hl.bind('S', hl.dsp.exec_cmd(terminal .. " fish -c 'spotify_player'"))
  hl.bind('R', hl.dsp.exec_cmd(terminal .. " fish -c 'claude /resume'"))
  hl.bind('U', hl.dsp.exec_cmd(terminal .. " fish -c 'claude /usage'"))
  hl.bind('Return', hl.dsp.submap 'reset')
  hl.bind('Escape', hl.dsp.submap 'reset')
  hl.bind('catchall', hl.dsp.submap 'reset')
end)
hl.bind(main_mod .. ' + E', hl.dsp.submap 'launch')
