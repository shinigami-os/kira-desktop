# ================================
# Kira Linux - foot configuration
# ================================

[main]
font=JetBrainsMono Nerd Font:size=11
dpi-aware=yes

# Terminal
term=xterm-256color
shell=/usr/bin/zsh
app-id=foot
title=foot terminal

# Padding
pad=8x8

# --- SCROLLBACK ---
[scrollback]
# set a really hight history for big debugging
lines=10000

# --- SWAY ---
[csd]
preferred=none

# --- SHORTCUTS ---
[key-bindings]
clipboard-copy=Control+c
clipboard-paste=Control+v

# --- CURSOR ---
[cursor]
blink=yes

# --- MOUSE ---
[mouse]
hide-when-typing=yes

# --- SEARCH ---
[search-bindings]
cancel=Escape
find-prev=Shift+F3
find-next=F3
delete-prev-word=Control+BackSpace


# --- PTY OVERWRITE ---
[text-bindings]
\x03=Control+Shift+c
\x17=Control+BackSpace

# --- THEME ---
[colors]
foreground=%ft_text%
background=%ft_base%
cursor=%ft_primary%

selection-foreground=%ft_base%
selection-background=%ft_primary%

# ANSI colors
# These map to the 16 terminal colors apps use for syntax highlighting etc.
# regular = normal intensity, bright = bold/bright intensity

regular0=%ft_base%
regular1=%ft_secondary%
regular2=%ft_green%
regular3=%ft_yellow%
regular4=%ft_primary_dim%
regular5=%ft_primary%
regular6=%ft_cyan%
regular7=%ft_subtext%

bright0=%ft_muted%
bright1=%ft_secondary%
bright2=%ft_green%
bright3=%ft_yellow%
bright4=%ft_primary%
bright5=%ft_primary%
bright6=%ft_cyan_bright%
bright7=%ft_text%