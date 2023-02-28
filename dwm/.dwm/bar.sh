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

pulse () {
  VOL=$(pamixer --get-volume)
  STATE=$(pamixer --get-mute)
  
  printf "%s" "$SEP1"
  if [ "$STATE" = "true" ] || [ "$VOL" -eq 0 ]; then
      printf "AMUT%%"
  elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
      printf "A%s%%" "$VOL"
  elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
      printf "A%s%%" "$VOL"
  else
      printf "A%s%%" "$VOL"
  fi
  printf "%s\n" "$SEP2"
}

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$crust^ ^b$yellow^ 󰇄 "
  printf "^c$crust^ ^b$yellow^$cpu_val"
}

battery() {
  # capacity_0="$(cat /sys/class/power_supply/BAT0/capacity)"
  # capacity_1="$(cat /sys/class/power_supply/BAT1/capacity)"

  # capacity=$(((capacity_0 + capacity_1) / 2))
  capacity=100
  
  printf " B$capacity%% "
}

brightness() {
  value=$(cat /sys/class/backlight/*/brightness)
  percentage=$(echo "scale=2; $value / 8.54" | bc)
  printf "L%.0f%%" "$percentage"
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
	printf " $(date '+%I:%M %P') "
}

today() {
	printf " $(date '+%b %e') "
}

net() {
  if nc -zw1 google.com 443; then
    printf "^c$crust^^b$green^  i  "
  else
    printf "^c$crust^^b$red^  !  "
  fi
}

while true; do

  # [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  # interval=$((interval + 1))

  # sleep 1 && xsetroot -name "$updates $(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock)"
  # sleep 1 && xsetroot -name "$(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock)"
  if hash dockd 2>/dev/null; then
    sleep 1 && xsetroot -name "^c$text^^b$surface0^  $(brightness)  ^b$base^  $(battery)  $(net)^c$text^^b$base^  $(today)  ^b$surface0^  $(clock)  ^b$surface1^  $(pulse)  "
  else
    sleep 1 && xsetroot -name "^c$text^$(net)^c$text^^b$base^  $(today)  ^b$surface0^  $(clock)  ^b$surface1^  $(pulse)  "
  fi

done
