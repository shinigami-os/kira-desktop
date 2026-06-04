# ============================================
# Kira Linux - swaylock-effects configuration
# ============================================

# Background
image=%KIRA_CONFIG%/current-wallpaper
effect-blur=7x5
effect-vignette=0.5:0.8
scaling=fill

# Clock overlay
clock
timestr=%H:%M
datestr=%a %d %B

# Indicator
indicator
indicator-radius=80
indicator-thickness=6
indicator-idle-visible=false

# Colors (rrggbb or rrggbbaa, no #)
inside-color=%sl_base%
inside-clear-color=%sl_surface0%
inside-ver-color=%sl_surface1%
inside-wrong-color=%sl_surface1%

ring-color=%sl_surface2%
ring-clear-color=%sl_primary%
ring-ver-color=%sl_primary_dim%
ring-wrong-color=%sl_secondary%

key-hl-color=%sl_primary%
bs-hl-color=%sl_secondary%

text-color=%sl_text%
text-clear-color=%sl_text%
text-ver-color=%sl_text%
text-wrong-color=%sl_secondary%
text-caps-lock-color=%sl_yellow%

line-color=00000000
line-clear-color=00000000
line-ver-color=00000000
line-wrong-color=00000000

separator-color=00000000

# Layout
font=Raleway
font-size=24

# Misc
show-failed-attempts
ignore-empty-password