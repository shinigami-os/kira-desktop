# =============================================================================
# Kira Linux - Mako notification daemon configuration
# =============================================================================

font=Raleway 13
background-color=#%mk_surface1%
text-color=#%mk_text%
border-color=#%mk_primary%
border-size=1
border-radius=8

width=360
height=120
anchor=top-center
margin=40
padding=12

default-timeout=5000
ignore-timeout=0
max-visible=5
sort=-time

icons=1
icon-path=/usr/share/icons/hicolor
max-icon-size=48

[urgency=low]
border-color=#%mk_muted%
default-timeout=3000

[urgency=normal]
border-color=#%mk_primary%

[urgency=critical]
border-color=#%mk_secondary%
text-color=#%mk_secondary%
default-timeout=0