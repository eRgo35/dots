#!/bin/bash

interval=0

# load colors
# . ~/.config/bar_themes/onedark

# dusk color palette path
dusk=$HOME/.cache/dusk/pywal

# colors
rosewater=$(jq -r '.colors.color16' $dusk)
flamingo=$(jq -r '.colors.color17' $dusk)
pink=$(jq -r '.colors.color18' $dusk)
mauve=$(jq -r '.colors.color19' $dusk)
maroon=$(jq -r '.colors.color20' $dusk)
red=$(jq -r '.colors.color21' $dusk)
peach=$(jq -r '.colors.color22' $dusk)
yellow=$(jq -r '.colors.color23' $dusk)
green=$(jq -r '.colors.color24' $dusk)
teal=$(jq -r '.colors.color25' $dusk)
sky=$(jq -r '.colors.color26' $dusk)
sapphire=$(jq -r '.colors.color27' $dusk)
blue=$(jq -r '.colors.color28' $dusk)
lavender=$(jq -r '.colors.color29' $dusk)
text=$(jq -r '.colors.color30' $dusk)
subtext1=$(jq -r '.colors.color31' $dusk)
subtext0=$(jq -r '.colors.color32' $dusk)
overlay2=$(jq -r '.colors.color33' $dusk)
overlay1=$(jq -r '.colors.color34' $dusk)
overlay0=$(jq -r '.colors.color35' $dusk)
surface2=$(jq -r '.colors.color36' $dusk)
surface1=$(jq -r '.colors.color37' $dusk)
surface0=$(jq -r '.colors.color38' $dusk)
base=$(jq -r '.colors.color39' $dusk)
mantle=$(jq -r '.colors.color40' $dusk)
crust=$(jq -r '.colors.color41' $dusk)

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
  capacity_0="$(cat /sys/class/power_supply/BAT0/capacity)"
  capacity_1="$(cat /sys/class/power_supply/BAT1/capacity)"

  capacity="$capacity_0+$capacity_1"
  # capacity=$(((capacity_0 + capacity_1) / 2))

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
