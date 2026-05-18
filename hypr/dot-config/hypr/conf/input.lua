-- INPUT

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "altgr-intl",
        kb_model = "",
        kb_options = "altwin:swap_lalt_lwin",
        kb_rules = "",

        repeat_rate = 35,
        repeat_delay = 200,

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            tap_and_drag = true,
            tap_to_click = true,
            disable_while_typing = true,
            natural_scroll = true,
            drag_lock = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})
