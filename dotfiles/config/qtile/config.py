from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
import os, subprocess

mod = "mod4"
terminal = "alacritty"
browser = "brave"

keys = [
    ## Session // Exit App // <><Shift> c ##
    Key([mod, "shift"], "c", lazy.window.kill(), desc='Kill active window'),

    ## Session // Logout // <><Shift> q ##
    Key([mod, "shift"], "q", lazy.shutdown(), desc='Logout menu'),

    ## Session // Restart // <><Shift> r ##
    Key([mod, "shift"], "r", lazy.restart(), desc='Restart Qtile'),

    ## Launch // Terminal // <> Enter ##
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    ## Launch // Browser // <><Shift> b ##
    Key([mod, "shift"], "b", lazy.spawn(browser), desc='Brave'),
    
    ## Launch // File Manager // <><Shift> f ##
    
    ## session // lock screen // <><shift> s ##
    Key([mod], "s", lazy.spawn("gnome-screensaver-command -l"), desc='Lock'),
     
    ## session // Launch password // <><shift> p ##
    
    ## Split vertically/horizontally // <><shift> v ##
    
    ## session // Launch programs // <><shift> Enter ##
    Key([mod, "shift"], "Return", lazy.spawn("rofi -show drun -display-drun \"Run: \" -drun-display-format \"{name}\""), desc="Launch terminal"),
    
    ## Launch // Keybinding Viewer // <><Shift> ? ##
    # bindsym $mod+? exec --no-startup-id ilia -p keybindings -a -t $ilia.stylesheet
    
    ## Navigate // Relative Window // <> k j h l ##
    
    # Toggle bar visibility
    ## Modify // Toggle Bar // <> i ##
    
    ## Modify // Containing Workspace // <><Ctrl><Shift> k j h l ##
    
    ## Modify // Window Position // <><Shift> k j h l ##
    
    ## Modify // Window Fullscreen Toggle // <> f ##
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),
 
    ## Modify // Window Floating Toggle // <><Shift> f ##
    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc='toggle floating'),

    ## Modify // Move Window to Workspace 1 - 10 // <><Shift> 0..9 ##

    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key(
    #     [mod, "shift"],
    #     "Return",
    #     lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack",
    # ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    # Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    # Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    # Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    ### Switch focus to specific monitor (out of three)
    # Key([mod], "w", lazy.to_screen(0), desc='Keyboard focus to monitor 1'),
    # Key([mod], "e", lazy.to_screen(1), desc='Keyboard focus to monitor 2'),
    # Key([mod], "r", lazy.to_screen(2), desc='Keyboard focus to monitor 3'),
    ### Switch focus of monitors
    Key([mod], "n", lazy.next_screen(), desc='Move focus to next monitor'),
    Key([mod], "b", lazy.prev_screen(), desc='Move focus to prev monitor'),

]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(border_normal="#000000", border_focus="#33658a", border_width=2),
    layout.Max(border_normal="#000000", border_focus="#33658a", border_width=2),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(border_normal="#000000", border_focus="#33658a", border_width=2),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    layout.VerticalTile(border_normal="#000000", border_focus="#33658a", border_width=2),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.CurrentLayout(),
                widget.WindowName(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.Systray(),
            ],
            24,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.CurrentLayout(),
                widget.WindowName(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "LG3D"
