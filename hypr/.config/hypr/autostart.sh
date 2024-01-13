#!/bin/zsh

hyprpaper & disown
wayvnc & disown
/usr/lib/polkit-kde-authentication-agent-1 &
dunst &
fcitx5 -d &
flameshot &
easyeffects --gapplication-service &

$HOME/.config/waybar/launcher.sh &
$HOME/.config/hypr/session.sh &