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

-- Toggle workspace layout between monocle and its previous layout.
-- Falls back to 'master' if no previous layout is stored.
local prev_layouts = {}

function M.toggle_monocle()
  return function()
    local ws = hl.get_active_workspace()
    if not ws then return end
    local id = tostring(ws.id)
    if ws.tiled_layout == 'monocle' then
      local restore = prev_layouts[id] or 'master'
      prev_layouts[id] = nil
      hl.workspace_rule { workspace = id, layout = restore }
    else
      prev_layouts[id] = ws.tiled_layout
      hl.workspace_rule { workspace = id, layout = 'monocle' }
    end
  end
end

-- Toggle window maximize (fills workspace, waybar stays) without inner
-- (client) fullscreen. fullscreenstate sets explicit state, so toggle by hand.
function M.toggle_maximize()
  return function()
    local w = hl.get_active_window()
    if not w then return end
    -- Already maximized: un-maximize.
    if w.fullscreen ~= 0 then
      hl.dispatch(hl.dsp.window.fullscreen_state { internal = 0, client = 0 })
      return
    end
    -- Sole window already fills the workspace: nothing to maximize.
    local ws = hl.get_active_workspace()
    if ws and ws.windows <= 1 then return end
    hl.dispatch(hl.dsp.window.fullscreen_state { internal = 1, client = 0 })
  end
end

-- Toggle inner (client) fullscreen while keeping the window's current format.
-- Pass the current internal mode back explicitly (instead of -1) so a maximized
-- window stays maximized when the client state flips.
function M.toggle_inner_fullscreen()
  return function()
    local w = hl.get_active_window()
    if not w then return end
    local client = (w.fullscreen_client ~= 0) and 0 or 2
    hl.dispatch(hl.dsp.window.fullscreen_state { internal = w.fullscreen, client = client })
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
