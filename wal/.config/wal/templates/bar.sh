#!/bin/bash

function lighten_color() {{
  offset=20

  hex_color=$1
  hex_color=${{hex_color:1}}

  red=${{hex_color:0:2}}
  green=${{hex_color:2:2}}
  blue=${{hex_color:4:2}}

  red_dec=$(printf "%d" 0x$red)
  green_dec=$(printf "%d" 0x$green)
  blue_dec=$(printf "%d" 0x$blue)

  if [[ $red_dec -lt 128 ]]; then
    red_dec_l=$((red_dec+offset))
    green_dec_l=$((green_dec+offset))
    blue_dec_l=$((blue_dec+offset))
  else
    red_dec_l=$((red_dec-offset))
    green_dec_l=$((green_dec-offset))
    blue_dec_l=$((blue_dec-offset))
  fi

  red=$(printf "%02X" $red_dec_l)
  green=$(printf "%02X" $green_dec_l)
  blue=$(printf "%02X" $blue_dec_l)

  echo "#$red$green$blue"
}}

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

# Special
background={color0}
foreground={color15}
cursor={color15}

# Colors
color0={color0}
color1={color1}
color2={color2}
color3={color3}
color4={color4}
color5={color5}
color6={color6}
color7={color7}
color8={color8}
color9={color9}
color10={color10}
color11={color11}
color12={color12}
color13={color13}
color14={color14}
color15={color15}

background0=$(lighten_color $background)
background1=$(lighten_color $background0)
background2=$(lighten_color $background1)

pulse () {{
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
}}

cpu() {{
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$background^ ^b$yellow^ 󰇄 "
  printf "^c$background^ ^b$yellow^$cpu_val"
}}

battery() {{
  capacity_0="$(cat /sys/class/power_supply/BAT0/capacity)"
  capacity_1="$(cat /sys/class/power_supply/BAT1/capacity)"

  capacity="$capacity_0+$capacity_1"
  # capacity=$(((capacity_0 + capacity_1) / 2))

  printf " B$capacity%% "
}}

brightness() {{
  value=$(cat /sys/class/backlight/*/brightness)
  percentage=$(echo "scale=2; $value / 8.54" | bc)
  printf "L%.0f%%" "$percentage"
}}

mem() {{
  printf "^c$background^^b$green^  "
  printf "^c$background^^b$green^ $(free -h | awk '/^Mem/ {{ print $3 }}' | sed s/i//g)"
}}

wlan() {{
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$background^ ^b$blue^ 󰤨 ^c$background^ ^b$blue^Connected" ;;
	down) printf "^c$background^ ^b$blue^ 󰤭 ^c$background^ ^b$blue^Disconnected" ;;
	esac
}}

clock() {{
	printf " $(date '+%I:%M %P') "
}}

today() {{
	printf " $(date '+%b %e') "
}}

net() {{
  if nc -zw1 google.com 443; then
    printf "^c$background^^b$green^  i  "
  else
    printf "^c$background^^b$red^  !  "
  fi
}}

while true; do

  # [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  # interval=$((interval + 1))

  # sleep 1 && xsetroot -name "$updates $(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock)"
  # sleep 1 && xsetroot -name "$(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock)"
  if hash dockd 2>/dev/null; then
    sleep 1 && xsetroot -name "^c$foreground^^b$background1^  $(brightness)  ^b$background0^  $(battery)  $(net)^c$foreground^^b$background0^  $(today)  ^b$background1^  $(clock)  ^b$background2^  $(pulse)  "
  else
    sleep 1 && xsetroot -name "^c$foreground^$(net)^c$foreground^^b$background0^  $(today)  ^b$background1^  $(clock)  ^b$background2^  $(pulse)  "
  fi

done
