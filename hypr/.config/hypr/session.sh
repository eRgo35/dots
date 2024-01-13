#!/bin/zsh

lock="swaylock \
    --screenshots \
    --effect-pixelate 20 \
    --effect-vignette 0.5:0.5 \
    --fade-in 0.2"
screenoff="hyprctl dispatch dpms off"
screenon="hyprctl dispatch dpms on"

swayidle -w timeout 600 "if pgrep -x swaylock; then $screenoff; fi" resume "$screenon" & disown
swayidle -w timeout 300 "$lock" & disown
