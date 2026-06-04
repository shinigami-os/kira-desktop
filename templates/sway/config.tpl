# ===================================================
# Kira Linux - SwayFX Configuration
# ===================================================
# To list available outputs: swaymsg -t get_outputs
# To list available inputs:  swaymsg -t get_inputs
# ===================================================

# --- Variables ---

set $mod Mod4
set $term foot
set $launcher fuzzel
set $files axfm
set $settings kira-settings
set $locker swaylock-effects --image $(cat $HOME/.config/kira-desktop/current-wallpaper 2>/dev/null) --effect-blur 7x5 --clock
set $runner  kira-run
set $calc    menu-qalc-wayland

font pango:Raleway 11

# --- Output ---
# Kira sets a solid base color by default.
# To configure a specific monitor, add lines like:
#   output HDMI-A-1 resolution 1920x1080 position 1920,0
#   output eDP-1 resolution 1920x1080 position 0,0
# Run 'swaymsg -t get_outputs' to discover your output names.

output * bg %base% solid_color

# --- Input ---

input "type:touchpad" {
    tap enabled
    natural_scroll disabled
    dwt enabled
    middle_emulation enabled
    scroll_method two_finger
}

input "type:keyboard" {
    xkb_layout fr
    xkb_variant azerty
}

# --- Appearance ---

gaps inner 4
gaps outer 8

default_border pixel 2
default_floating_border pixel 2
titlebar_padding 0
titlebar_border_thickness 0

corner_radius 8

shadows enable
shadow_blur_radius 20
shadow_color %base%CC

blur enable
blur_passes 3
blur_radius 5

# Window colors             border          background      text            indicator       child_border
client.focused              %primary%       %surface1%      %text%          %primary%       %primary%
client.focused_inactive     %surface2%      %surface0%      %subtext%       %surface2%      %surface2%
client.unfocused            %surface2%      %surface0%      %muted%         %surface2%      %surface2%
client.urgent               %secondary%     %surface1%      %text%          %secondary%     %secondary%

# --- Keybindings ---

# Applications
bindsym ctrl+alt+t          exec $term
bindsym $mod+d              exec $launcher
bindsym $mod+e              exec $files
bindsym $mod+u              exec $settings

# Window management
bindsym $mod+q              kill
bindsym $mod+f              fullscreen toggle
bindsym $mod+h              splith
bindsym $mod+v              splitv
bindsym $mod+Shift+Space    floating toggle

# Focus
bindsym $mod+i              focus up
bindsym $mod+j              focus left
bindsym $mod+o              focus down
bindsym $mod+k              focus right

# Move window
bindsym $mod+Up             move up
bindsym $mod+Down           move down
bindsym $mod+Left           move left
bindsym $mod+Right          move right

# Workspaces
bindsym $mod+1              workspace number 1
bindsym $mod+2              workspace number 2
bindsym $mod+3              workspace number 3
bindsym $mod+4              workspace number 4
bindsym $mod+5              workspace number 5
bindsym $mod+6              workspace number 6
bindsym $mod+7              workspace number 7
bindsym $mod+8              workspace number 8
bindsym $mod+9              workspace number 9
bindsym $mod+0              workspace number 10

bindsym $mod+Shift+1        move container to workspace number 1
bindsym $mod+Shift+2        move container to workspace number 2
bindsym $mod+Shift+3        move container to workspace number 3
bindsym $mod+Shift+4        move container to workspace number 4
bindsym $mod+Shift+5        move container to workspace number 5
bindsym $mod+Shift+6        move container to workspace number 6
bindsym $mod+Shift+7        move container to workspace number 7
bindsym $mod+Shift+8        move container to workspace number 8
bindsym $mod+Shift+9        move container to workspace number 9
bindsym $mod+Shift+0        move container to workspace number 10

# Next/prev workspace
bindsym $mod+Left       workspace prev
bindsym $mod+Right      workspace next
bindsym --whole-window $mod+button4     workspace prev
bindsym --whole-window $mod+button5     workspace next

# Move container to next/prev workspace
bindsym $mod+Alt+Left     move container to workspace prev
bindsym $mod+Alt+Right    move container to workspace next

# Scratchpad
bindsym $mod+minus          scratchpad show
bindsym $mod+Shift+minus    move scratchpad

# Screenshot
bindsym Print               exec flameshot gui
bindsym $mod+Shift+s        exec flameshot gui

# Lock
bindsym $mod+l              exec $locker

# Reload
bindsym $mod+Shift+r        reload

# Widgets
bindsym $mod+r exec $runner
bindsym $mod+c exec $calc

# --- Floating rules ---
# Define which windows open floating by default

for_window [app_id="floating_foot"]    floating enable, resize set 800 500
for_window [app_id="kira-settings"]    floating enable
for_window [app_id="pavucontrol"]      floating enable, resize set 700 450
for_window [app_id="nm-connection-editor"] floating enable

# --- Autostart ---

exec_always kira-theme apply $(cat %KIRA_CONFIG%/current-theme 2>/dev/null || echo "kira-default")
exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
exec mako
exec_always $HOME/.config/eww/launch-bars.sh
exec swaybg -c %base%

# --- Others ---

xwayland enable
focus_follows_mouse yes
workspace_layout splith
