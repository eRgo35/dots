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
xset s off &
xset s noblank &
xset s noexpose &
xset c on &
xset -dpms &

# auths
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
gnome-keyring-daemon &

# wallpapers
nitrogen --restore &

# notification daemon
dunst &

# start dwm
exec dwm
