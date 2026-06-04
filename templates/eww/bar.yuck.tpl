;; Kira Linux - eww bar

;; -- Polls --

(defpoll clock_time :interval "1s"
"date '+%H:%M:%S'")

(defpoll clock_date :interval "60s"
"date '+%a %d %b'")

(defpoll cpu_usage :interval "3s"
"cat /proc/stat | awk 'NR==1{usage=($2+$4)*100/($2+$3+$4+$5); printf \"%.0f\", usage}'")

(defpoll ram_usage :interval "3s"
"free | awk '/Mem:/{printf \"%.0f\", $3/$2*100}'")

(defpoll cpu_temp :interval "5s"
"cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null | awk '{printf \"%.0f\", $1/1000}' || echo '?'")

(defpoll volume_val :interval "1s"
"pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%'")

(defpoll volume_muted :interval "1s"
"pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'")

(defpoll net_iface :interval "5s"
"ip route get 1.1.1.1 2>/dev/null | awk '{print $5}' | head -1 || echo 'none'")

(defpoll net_ssid :interval "10s"
"iw dev $(ip route get 1.1.1.1 2>/dev/null | awk '{print $5}' | head -1) link 2>/dev/null | awk '/SSID/{print $2}' || echo ''")

(defpoll battery_val :interval "30s"
"cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo ''")

(defpoll battery_status :interval "30s"
"cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo ''")

(defpoll window_title :interval "0.5s"
"swaymsg -t get_tree | python3 -c \"
import json,sys
tree=json.load(sys.stdin)
def find_focused(n):
    if n.get('focused'): return n.get('name','')
    for c in n.get('nodes',[])+n.get('floating_nodes',[]): 
        r=find_focused(c)
        if r is not None: return r
    return None
print(find_focused(tree) or '')
\" 2>/dev/null")

(defpoll music_title :interval "2s"
"playerctl metadata title 2>/dev/null | head -c 40 || echo ''")

(defpoll music_artist :interval "2s"
"playerctl metadata artist 2>/dev/null || echo ''")

(defpoll music_status :interval "2s"
"playerctl status 2>/dev/null || echo 'Stopped'")

(defpoll workspaces :interval "0.5s"
"swaymsg -t get_workspaces | python3 -c \"
import json,sys
ws=json.load(sys.stdin)
icons=['','','','','','','','','','']
result=[]
for w in sorted(ws,key=lambda x:x['num']):
    focused='true' if w['focused'] else 'false'
    urgent='true' if w['urgent'] else 'false'
    icon=icons[min(w['num']-1,len(icons)-1)]
    result.append(f\\\"{w['num']}:{icon}:{focused}:{urgent}\\\")
print(' '.join(result))
\" 2>/dev/null")

;; -- Widgets --

(defwidget workspace-btn [num icon focused urgent]
(button
    :class {focused == "true" ? "workspace-btn focused" :
            urgent  == "true" ? "workspace-btn urgent"  :
                                "workspace-btn"}
    :onclick "swaymsg workspace number ${num}"
    icon))

(defwidget workspaces-widget []
(box :class "workspaces" :spacing 4 :space-evenly false
    (for ws in {split(workspaces, " ")}
    (workspace-btn
        :num    {split(ws, ":")[0]}
        :icon   {split(ws, ":")[1]}
        :focused {split(ws, ":")[2]}
        :urgent  {split(ws, ":")[3]}))))

(defwidget clock-widget []
(box :class "clock" :spacing 6 :space-evenly false
    (label :class "clock-time" :text clock_time)
    (label :class "clock-date" :text clock_date)))

(defwidget cpu-widget []
(box :class "sysstat cpu" :spacing 4 :space-evenly false
    (label :class "sysstat-icon" :text "")
    (label :class "sysstat-val"  :text "${cpu_usage}%")))

(defwidget ram-widget []
(box :class "sysstat ram" :spacing 4 :space-evenly false
    (label :class "sysstat-icon" :text "")
    (label :class "sysstat-val"  :text "${ram_usage}%")))

(defwidget temp-widget []
(box :class "sysstat temp" :spacing 4 :space-evenly false
    (label :class "sysstat-icon" :text "")
    (label :class "sysstat-val"  :text "${cpu_temp}°C")))

(defwidget volume-widget []
(box :class "volume" :spacing 4 :space-evenly false
    (label :class "volume-icon"
        :text {volume_muted == "yes" ? "󰝟" : 
                volume_val  == "0"   ? "󰕿" :
                volume_val  <  "50"  ? "󰖀" : "󰕾"})
    (label :class "volume-val" :text "${volume_val}%")))

(defwidget network-widget []
(box :class "network" :spacing 4 :space-evenly false
    (label :class "network-icon"
        :text {net_iface == "none" ? "󰤭" :
                net_ssid  != ""     ? "󰤨" : "󰈀"})
    (label :class "network-val"
        :text {net_ssid != "" ? net_ssid : net_iface})))

(defwidget battery-widget []
(box :class "battery"
    :visible {battery_val != ""}
    :spacing 4 :space-evenly false
    (label :class "battery-icon"
        :text {battery_status == "Charging" ? "󰂄" :
                battery_val > "80" ? "󰁹" :
                battery_val > "60" ? "󰂀" :
                battery_val > "40" ? "󰁾" :
                battery_val > "20" ? "󰁼" : "󰁺"})
    (label :class "battery-val" :text "${battery_val}%")))

(defwidget music-widget []
(box :class "music"
    :visible {music_status != "Stopped" && music_status != ""}
    :spacing 4 :space-evenly false
    (label :class "music-icon"
        :text {music_status == "Playing" ? "󰎇" : "󰏤"})
    (label :class "music-title"
        :limit-width 35
        :text {music_artist != "" ?
                "${music_artist} - ${music_title}" :
                music_title})))

(defwidget window-widget []
(label :class "window-title"
        :limit-width 50
        :text window_title))

;; -- Left / Center / Right ---

(defwidget bar-left []
(box :class "bar-left" :spacing 12 :space-evenly false
    (window-widget)
    (music-widget)))

(defwidget bar-center []
(box :class "bar-center" :spacing 12 :space-evenly false
    (cpu-widget)
    (ram-widget)
    (temp-widget)
    (workspaces-widget)
    (clock-widget)))

(defwidget bar-right []
(box :class "bar-right" :spacing 12 :space-evenly false
    (volume-widget)
    (network-widget)
    (battery-widget)))

;; -- Window --

(defwidget bar-widget [monitor]
(centerbox :class "bar"
    (bar-left)
    (bar-center)
    (bar-right)))

(defwindow bar
:monitor monitor
:geometry (geometry
    :x "0px" :y "0px"
    :width "100%" :height "32px"
    :anchor "top center")
:stacking "fg"
:exclusive true
(bar-widget :monitor monitor))
