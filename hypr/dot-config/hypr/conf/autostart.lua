-- AUTOSTART

hl.on('hyprland.start', function()
  -- Environment
  hl.exec_cmd 'dbus-update-activation-environment --systemd --all'

  -- UI / WM
  hl.exec_cmd 'waybar'
  hl.exec_cmd 'hypridle'
  hl.exec_cmd 'systemctl --user start hyprpolkitagent'
  hl.exec_cmd 'swaybg -o eDP-2 -m fill -i ~/Pictures/luzern.jpg'
  hl.exec_cmd 'swaybg -m fill -i ~/Pictures/luzern.jpg'
  hl.exec_cmd 'vicinae server'

  -- Utils
  hl.exec_cmd 'nm-applet --indicator'
  hl.exec_cmd 'wl-clip-persist --clipboard regular'
  hl.exec_cmd 'insync start'
end)
