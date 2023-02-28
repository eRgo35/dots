#!/bin/sh

# screenlayout setup for odin
$HOME/.screenlayout/main.sh

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        # shellcheck source=/dev/null
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xset -b # disable bell

# ssh agent setup
eval `/usr/bin/ssh-agent`

if test -f /usr/lib/openssh/x11-ssh-askpass # Archlinux
then
	SSH_ASKPASS=/usr/lib/openssh/x11-ssh-askpass ssh-add < /dev/null
fi

if test -f /usr/lib/ssh/x11-ssh-askpass # Debian
then
	SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
fi

# some merges
xsetroot -cursor_name left_ptr &
export GTK2_RC_FILES="$HOME/.gtkrc-2.0" &
xrdb merge .Xresources &

# compositor
picom -b --vsync &

# set keyboard layout
setxkbmap pl &

# enable local fonts in .fonts directory
xset +fp /usr/share/fonts/local &
xset +fp /usr/share/fonts/misc &
xset +fp ~/.fonts &
xset fp rehash &
fc-cache -fv &

# powersaving options
# xset s off &
# xset s noblank &
# xset s noexpose &
xset c on &
xset -dpms &
xset s 900 &

# auths
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
gnome-keyring-daemon &

## Map super key to trigger rofi when used alone
# xcape -e 'Super_L=Super_L|Shift_L|space' &

# wallpapers
nitrogen --restore &

## Set screen locker
xss-lock -v -- betterlockscreen -l --time-format '%I:%M %p' &

## Desktop portal
/usr/lib/xdg-desktop-portal-gtk &

# notification daemon
dunst &

## Screenshot daemon
flameshot &

# Easyeffects daemon
easyeffects --gapplication-service &

## Telegram daemon
telegram-desktop -startintray &

## Caffeine-ng
caffeine >/dev/null 2>&1 &

## Ulauncher
ulauncher --hide-window --no-window-shadow >/dev/null 2>&1 &

# Emacs Server
emacs --daemon &

## THINKPAD-SPECIFIC 
hash dockd && dockd --daemon &

# status bar
$HOME/.dwm/bar.sh &

# start dwm
exec dwm
