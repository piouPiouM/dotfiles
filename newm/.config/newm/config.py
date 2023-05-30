from __future__ import annotations
from typing import Callable, Any

import os
import pwd
import time
import logging

from newm.layout import Layout
from newm.helper import BacklightManager, WobRunner, PaCtl

from pywm import (
    PYWM_MOD_LOGO,
    PYWM_MOD_ALT
)

def on_startup():
    os.system("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots")
    os.system("waybar &")

def on_reconfigure():
    os.system("notify-send newm \"Reloaded config\" &")

logger = logging.getLogger(__name__)

background = {
    'path': os.environ['HOME'] + '/Images/wallpapers/wallhaven-4331.jpg',
    'anim': True
}

outputs = [
    { 'name': 'eDP-1', 'width': 1920, 'height': 1200 },
    #  { 'name': 'virt-1', 'pos_x': -1280, 'pos_y': 0, 'width': 1280, 'height': 720 }
]

pywm = {
    #  'xkb_model': "macintosh",
    'xkb_layout': "fr(oss)",
    #  'xkb_options': "caps:escape",
    'enable_xwayland': True
}

wob_runner = WobRunner("wob -a bottom -M 100")
backlight_manager = BacklightManager(anim_time=1., bar_display=wob_runner)
kbdlight_manager = BacklightManager(args="--device='*::kbd_backlight'", anim_time=1., bar_display=wob_runner)

def synchronous_update() -> None:
    backlight_manager.update()
    kbdlight_manager.update()

pactl = PaCtl(0, wob_runner)

def key_bindings(layout: Layout) -> list[tuple[str, Callable[[], Any]]]:
    return [
        ("L-h", lambda: layout.move(-1, 0)),
        ("L-j", lambda: layout.move(0, 1)),
        ("L-k", lambda: layout.move(0, -1)),
        ("L-l", lambda: layout.move(1, 0)),
        ("L-u", lambda: layout.basic_scale(1)),
        ("L-n", lambda: layout.basic_scale(-1)),
        ("L-t", lambda: layout.move_in_stack(1)),

        ("L-H", lambda: layout.move_focused_view(-1, 0)),
        ("L-J", lambda: layout.move_focused_view(0, 1)),
        ("L-K", lambda: layout.move_focused_view(0, -1)),
        ("L-L", lambda: layout.move_focused_view(1, 0)),

        ("L-C-h", lambda: layout.resize_focused_view(-1, 0)),
        ("L-C-j", lambda: layout.resize_focused_view(0, 1)),
        ("L-C-k", lambda: layout.resize_focused_view(0, -1)),
        ("L-C-l", lambda: layout.resize_focused_view(1, 0)),

        ("L-Return", lambda: os.system("kitty &")),
        ("L-q", lambda: layout.close_focused_view()),

        ("L-p", lambda: layout.ensure_locked(dim=True)),
        ("L-P", lambda: layout.terminate()),
        ("L-C", lambda: layout.update_config()),

        ("L-d", lambda: os.system("rofi -show drun -theme catppuccin &")),
        ("L-f", lambda: layout.toggle_fullscreen()),

        ("L-", lambda: layout.toggle_overview()),

        ("XF86MonBrightnessUp", lambda: backlight_manager.set(backlight_manager.get() + 0.1)),
        ("XF86MonBrightnessDown", lambda: backlight_manager.set(backlight_manager.get() - 0.1)),
        ("XF86KbdBrightnessUp", lambda: kbdlight_manager.set(kbdlight_manager.get() + 0.1)),
        ("XF86KbdBrightnessDown", lambda: kbdlight_manager.set(kbdlight_manager.get() - 0.1)),
        ("XF86AudioRaiseVolume", lambda: pactl.volume_adj(5)),
        ("XF86AudioLowerVolume", lambda: pactl.volume_adj(-5)),
        ("XF86AudioMute", lambda: pactl.mute()),
    ]

def rules(view):
    if view.app_id == "waybar":
        return { 'blur': { 'radius': 5, 'passes': 3 }}
    if view.app_id = "keepassxc":
        return { 'float': True }
    return None

view = {
    #  'padding': 0,
    'fullscreen_padding': 0,
    'rules': rules
}

panels = {
    'lock': {
        'cmd': 'kitty -e newm-panel-basic lock',
    },
    'launcher': {
        'cmd': 'kitty -e newm-panel-basic launcher'
    },
    #  'bottom_bar': {
    #      'native': {
    #          'enabled': True,
    #          'texts': lambda: [
    #              pwd.getpwuid(os.getuid())[0],
    #              time.strftime("%c"),
    #          ],
    #      }
    #  },
    #  'top_bar': {
    #      'native': {
    #          'enabled': True,
    #          'texts': lambda: [
    #              "newm",
    #              "powered by pywm"
    #          ],
    #      }
    #  },
}

bar = { 'enabled': False }

energy = {
    'idle_callback': backlight_manager.callback
}

swipe_zoom = {
    'grid_m': 1,
    'grid_ovr': 0.02,
}
