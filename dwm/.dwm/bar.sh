#!/bin/bash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
# . ~/.config/bar_themes/onedark

# colors

rosewater=#f4dbd6
flamingo=#f0c6c6
pink=#f5bde6
mauve=#c6a0f6
red=#ed8796
maroon=#ee99a0
peach=#f5a97f
yellow=#eed49f
green=#a6da95
teal=#8bd5ca
sky=#91d7e3
sapphire=#7dc4e4
blue=#8aadf4
lavender=#b7bdf8
text=#cad3f5
subtext1=#b8c0e0
subtext0=#a5adcb
overlay2=#939ab7
overlay1=#8087a2
overlay0=#6e738d
surface2=#5b6078
surface1=#494d64
surface0=#363a4f
base=#24273a
mantle=#1e2030
crust=#181926

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$crust^ ^b$yellow^ 󰇄 "
  printf "^c$crust^ ^b$yellow^$cpu_val"
}

pkg_updates() {
  #updates=$(doas xbps-install -un | wc -l) # void
  updates=$(checkupdates 2>/dev/null | wc -l) # arch
  # updates=$(aptitude search '~U' | wc -l)  # apt (ubuntu,debian etc)

  if [ -z "$updates" ]; then
    printf "  ^c$blue^    Fully Updated"
  else
    printf "  ^c$blue^    $updates"" updates"
  fi
}

battery() {
  capacity_0="$(cat /sys/class/power_supply/BAT0/capacity)"
  capacity_1="$(cat /sys/class/power_supply/BAT1/capacity)"

  capacity=$(((capacity_0 + capacity_1) / 2))
  
  printf "^c$crust^ ^b$red^  ^b$red^ $capacity"
}

brightness() {
  printf "^c$crust^^b$peach^   "
  printf "^c$crust^^b$peach^%.0f\n" $(cat /sys/class/backlight/*/brightness)
}

mem() {
  printf "^c$crust^^b$green^  "
  printf "^c$crust^^b$green^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$crust^ ^b$blue^ 󰤨 ^c$crust^ ^b$blue^Connected" ;;
	down) printf "^c$crust^ ^b$blue^ 󰤭 ^c$crust^ ^b$blue^Disconnected" ;;
	esac
}

clock() {
	printf "^c$crust^ ^b$mauve^ 󱑁 "
	printf "^c$crust^ ^b$mauve^$(date '+%r')  "
}

while true; do

  # [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  # interval=$((interval + 1))

  # sleep 1 && xsetroot -name "$updates $(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock)"
  sleep 1 && xsetroot -name "$(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock)"
  # sleep 1 && xsetroot -name "$(cpu) $(mem) $(clock)"
done
