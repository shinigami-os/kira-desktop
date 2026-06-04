/* ============================
   Kira Linux - eww bar styles
   ============================ */

* {
    font-family: "Raleway", sans-serif;
    font-size: 13px;
    color: %text%;
}

.bar {
    background: %surface0%;
    border-bottom: 1px solid %surface2%;
    padding: 0 12px;
}

/* -- Layout -- */

.bar-left {
    padding-left: 8px;
}

.bar-center {
    /* centered by centerbox */
}

.bar-right {
    padding-right: 8px;
}

/* -- Window title -- */

.window-title {
    color: %subtext%;
    font-size: 12px;
    padding: 0 4px;
}

/* -- Music -- */

.music {
    padding: 0 6px;
    border-radius: 6px;
}

.music-icon {
    color: %primary%;
    font-family: "JetBrainsMono Nerd Font";
}

.music-title {
    color: %text%;
    font-size: 12px;
}

/* -- Sysstat -- */

.sysstat {
    padding: 2px 8px;
    border-radius: 6px;
    background: %surface1%;
}

.sysstat-icon {
    font-family: "JetBrainsMono Nerd Font";
    font-size: 11px;
    color: %primary_dim%;
}

.sysstat-val {
    font-family: "JetBrainsMono Nerd Font";
    font-size: 12px;
    color: %text%;
}

/* -- Workspaces -- */

.workspaces {
    padding: 0 4px;
}

.workspace-btn {
    font-family: "JetBrainsMono Nerd Font";
    font-size: 14px;
    color: %muted%;
    background: transparent;
    border: none;
    border-radius: 6px;
    padding: 2px 6px;
    transition: all 0.15s ease;
}

.workspace-btn:hover {
    color: %text%;
    background: %surface1%;
}

.workspace-btn.focused {
    color: %primary%;
    background: %surface1%;
}

.workspace-btn.urgent {
    color: %secondary%;
    background: %surface1%;
}

/* -- Clock -- */

.clock {
    padding: 0 6px;
}

.clock-time {
    font-family: "JetBrainsMono Nerd Font";
    font-size: 14px;
    font-weight: bold;
    color: %text%;
}

.clock-date {
    font-size: 11px;
    color: %subtext%;
}

/* -- Volume -- */

.volume {
    padding: 2px 8px;
    border-radius: 6px;
    background: %surface1%;
}

.volume-icon {
    font-family: "JetBrainsMono Nerd Font";
    color: %primary%;
}

.volume-val {
    font-family: "JetBrainsMono Nerd Font";
    font-size: 12px;
}

/* -- Network -- */

.network {
    padding: 2px 8px;
    border-radius: 6px;
    background: %surface1%;
}

.network-icon {
    font-family: "JetBrainsMono Nerd Font";
    color: %primary%;
}

.network-val {
    font-size: 12px;
}

/* -- Battery -- */

.battery {
    padding: 2px 8px;
    border-radius: 6px;
    background: %surface1%;
}

.battery-icon {
    font-family: "JetBrainsMono Nerd Font";
    color: %primary%;
}

.battery-val {
    font-family: "JetBrainsMono Nerd Font";
    font-size: 12px;
}
