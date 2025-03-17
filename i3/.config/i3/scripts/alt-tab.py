#!/usr/bin/env python
"""Mark i3 or Sway last focused container."""
from os import environ

from i3ipc import Connection, Event

MARK = ':i3b:'

try:
    i3 = Connection()
except FileNotFoundError:
    del environ['I3SOCK']
    i3 = Connection()

last = i3.get_tree().find_marked(f'^{MARK}$')
if not last:
    last = i3.get_tree().find_focused()
    last.command(f'mark --add {MARK}')
else:
    last = last[0]

def focus_handler(_, evt):
    """Mark a container on window focus change."""
    global last
    last.command(f'mark --add {MARK}')
    last = evt.container

i3.on(Event.WINDOW_FOCUS, focus_handler)
i3.main()
