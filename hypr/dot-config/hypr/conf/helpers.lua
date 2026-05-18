-- Shared helpers for conf/ files.
-- Non-trivial bind actions live here so keybinds.lua stays a flat list of
-- binds. Helpers used in binds return a function ready to pass to hl.bind.

local M = {}

-- Focus a window by exact class, else launch cmd.
function M.focus_or_launch(class, cmd)
  return function()
    for _, w in ipairs(hl.get_windows()) do
      if w.class == class then
        hl.dispatch(hl.dsp.focus { window = w })
        return
      end
    end
    hl.exec_cmd(cmd)
  end
end

-- Go to target workspace, or back to previous if already there.
-- If a special workspace is open, close it first.
function M.go_to_workspace(target)
  return function()
    local mon = hl.get_active_monitor()
    if mon and mon.active_special_workspace then
      local sname = mon.active_special_workspace.name:gsub('^special:', '')
      hl.dispatch(hl.dsp.workspace.toggle_special(sname))
      hl.dispatch(hl.dsp.focus { workspace = target })
      return
    end
    local cur = hl.get_active_workspace()
    if cur and cur.id == target then
      hl.dispatch(hl.dsp.focus { workspace = 'previous' })
    else
      hl.dispatch(hl.dsp.focus { workspace = target })
    end
  end
end

-- Minimize active window to a special workspace.
function M.minimize_to_special(special_name)
  return function()
    hl.dispatch(hl.dsp.workspace.toggle_special(special_name))
    hl.dispatch(hl.dsp.window.move { workspace = '+0' })
    hl.dispatch(hl.dsp.workspace.toggle_special(special_name))
    hl.dispatch(hl.dsp.window.move { workspace = 'special:' .. special_name })
    hl.dispatch(hl.dsp.workspace.toggle_special(special_name))
  end
end

-- Dispatch the layoutmsg matching the active layout (master vs dwindle).
function M.layout_msg(master_msg, dwindle_msg)
  return function()
    local ws = hl.get_active_workspace()
    local layout = ws and ws.tiled_layout
    if layout == 'dwindle' then
      hl.dispatch(hl.dsp.layout(dwindle_msg))
    elseif layout == 'master' then
      hl.dispatch(hl.dsp.layout(master_msg))
    end
  end
end

-- Move active window to monitor in direction; no-op if none (avoids warning).
function M.move_to_monitor(direction)
  return function()
    if hl.get_monitor(direction) then hl.dispatch(hl.dsp.window.move { monitor = direction }) end
  end
end

-- Move active window two directions in sequence (layout-move hack).
function M.move_window(dir_a, dir_b)
  return function()
    hl.dispatch(hl.dsp.window.move { direction = dir_a })
    hl.dispatch(hl.dsp.window.move { direction = dir_b })
  end
end

-- Disconnect all connected bluetooth devices.
function M.disconnect_bluetooth() hl.exec_cmd [[bluetoothctl devices Connected | awk '{print $2}' | xargs -rn1 bluetoothctl disconnect]] end

-- Disconnect bluetooth, stop time tracking, then lock the screen.
function M.lock_screen()
  return function()
    M.disconnect_bluetooth()
    hl.exec_cmd "track stop & hyprlock; notify-send -u critical 'Dont forget to track time!!!'"
  end
end

return M
