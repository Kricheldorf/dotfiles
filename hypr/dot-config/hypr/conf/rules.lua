-- MONITORS, LAYER RULES, WINDOW RULES, WORKSPACE RULES

-- MONITORS
hl.monitor({
    output = "DP-1",
    mode = "2560x1440@180.00Hz",
    position = "auto-center-right",
    scale = "1",
})

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto-center-right",
    scale = "1.333",
})

hl.monitor({
    output = "eDP-2",
    mode = "preferred",
    position = "auto-center-right",
    scale = "1",
})

hl.monitor({
    output = "DP-2",
    mode = "preferred",
    position = "auto-center-left",
})

-- LAYER RULES
hl.layer_rule({
    name = "layerrule-vicinae-blur",
    blur = true,
    ignore_alpha = 0,
    match = { namespace = "vicinae" },
})

hl.layer_rule({
    name = "vicinae-no-animation",
    no_anim = true,
    match = { namespace = "vicinae" },
})

-- WINDOW RULES

-- Ignore maximize requests
hl.window_rule({
    name = "windowrule-suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Common modals
hl.window_rule({ name = "windowrule-6", match = { title = "^(Open)$" }, float = true })
hl.window_rule({ name = "windowrule-7", match = { title = "^(Choose Files)$" }, float = true })
hl.window_rule({ name = "windowrule-8", match = { title = "^(Save As)$" }, float = true })
hl.window_rule({ name = "windowrule-9", match = { title = "^(Confirm to replace files)$" }, float = true })
hl.window_rule({ name = "windowrule-10", match = { title = "^(File Operation Progress)$" }, float = true })

hl.window_rule({
    name = "windowrule-11",
    match = { class = "^(google-chrome)$", title = "^(Open Files)$" },
    float = true,
})
hl.window_rule({
    name = "windowrule-12",
    match = { class = "^(google-chrome)$", title = "^(Open File)$" },
    float = true,
})
hl.window_rule({
    name = "windowrule-13",
    match = { class = "^(microsoft-edge)$", title = "^(Open Files)$" },
    float = true,
})
hl.window_rule({
    name = "windowrule-14",
    match = { class = "^(microsoft-edge)$", title = "^(Open File)$" },
    float = true,
})

hl.window_rule({
    name = "windowrule-15",
    match = { class = "pavucontrol" },
    center = true,
    float = true,
})
hl.window_rule({
    name = "windowrule-16",
    match = { title = "^(Volume Control)$" },
    center = true,
    float = true,
})
hl.window_rule({
    name = "windowrule-17",
    match = { title = "^(Bluetooth)$" },
    center = true,
    float = true,
})

hl.window_rule({
    name = "windowrule-size-webstorm-windows",
    match = { class = "^(jetbrains-webstorm)$", float = true },
    min_size = "1200 800",
    center = true,
})

-- WORKSPACE RULES
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
hl.workspace_rule({ workspace = "6", monitor = "DP-1" })
hl.workspace_rule({ workspace = "7", monitor = "DP-1" })
hl.workspace_rule({ workspace = "8", monitor = "DP-1" })
hl.workspace_rule({ workspace = "9", monitor = "DP-1" })
hl.workspace_rule({
    workspace = "10",
    monitor = "DP-2",
    gaps_in = 2.5,
    gaps_out = { top = 0, right = 540, bottom = 0, left = 0 },
    layout = "dwindle",
    default = true,
})

hl.workspace_rule({ workspace = "special:zen", on_created_empty = "zen-browser" })
hl.workspace_rule({ workspace = "special:magic", on_created_empty = "gtk-launch slack" })
hl.workspace_rule({
    workspace = "special:terminal",
    on_created_empty = "kitty --session shipix-dev.kitty-session",
})
hl.workspace_rule({
    workspace = "special:lazygit",
    on_created_empty = "kitty -d $DEFAULT_WORK_DIR fish -c 'lg; exec fish'",
})
hl.workspace_rule({
    workspace = "special:agent",
    on_created_empty = "kitty --hold -d $DEFAULT_WORK_DIR fish -c 'claude'",
})

-- XWAYLAND
hl.window_rule({
    name = "windowrule-fix-xwayland-dragging",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
