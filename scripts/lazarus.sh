#!/bin/bash

if [ "$EUID" -eq 0 ]
  then echo "Please do not run as root!"
  exit
fi

echo "=== Lazarus Ressurection Script ==="
echo "Note: This script is semi-automatic. User interaction may be required to continue!"

sleep 5
 
# working dir
mkdir -pv lazarus-tmp
cd lazarus-tmp

# paru package manager setup
echo "Installing paru"

sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..

# system update
echo "Preparing system update"

paru -Syyu

# installing all programs
echo "Installing additional software (this may take a long time!)"

paru -S \
adobe-source-code-pro-fonts \
alacritty \
bat \
betterlockscreen \
calf \
cantarell-fonts \
catppuccin-gtk-theme-frappe \
catppuccin-gtk-theme-latte \
catppuccin-gtk-theme-macchiato \
catppuccin-gtk-theme-mocha \
cjson \
clight \
clightd \
discord \
dunst \
easyeffects \
emacs \
eza \
fd \
feh \
firefox \
flameshot \
fzf \
geoclue \
gnome-keyring \
gnupg \
handbrake \
helvum \
jq \
json-c \
json-glib \
kleopatra \
kvantum \
less \
lib32-json-c \
linux-zen \
linux-zen-headers \
lsof \
lsp-plugins \
lsp-plugins-clap \
lsp-plugins-ladspa \
lsp-plugins-lv2 \
lsp-plugins-standalone \
lsp-plugins-vst \
lxappearance \
mate-polkit \
nemo \
neofetch \
nitrogen \
noto-fonts \
noto-fonts-cjk \
noto-fonts-emoji \
noto-fonts-extra \
obs-studio \
okular \
os-prober \
otf-aurulent-nerd \
otf-codenewroman-nerd \
otf-comicshanns-nerd \
otf-droid-nerd \
otf-firamono-nerd \
otf-hasklig-nerd \
otf-hermit-nerd \
otf-opendyslexic-nerd \
otf-overpass-nerd \
p7zip \
papirus-icon-theme \
python-pywal \
rofi \
rofi-calc \
seahorse \
stow \
telegram-desktop-bin \
ttf-3270-nerd \
ttf-agave-nerd \
ttf-anonymouspro-nerd \
ttf-arimo-nerd \
ttf-bigblueterminal-nerd \
ttf-bitstream-vera-mono-nerd \
ttf-cascadia-code-nerd \
ttf-cousine-nerd \
ttf-daddytime-mono-nerd \
ttf-dejavu-nerd \
ttf-fantasque-nerd \
ttf-firacode-nerd \
ttf-go-nerd \
ttf-hack-nerd \
ttf-heavydata-nerd \
ttf-iawriter-nerd \
ttf-ibmplex-mono-nerd \
ttf-inconsolata-go-nerd \
ttf-inconsolata-lgc-nerd \
ttf-inconsolata-nerd \
ttf-iosevka-nerd \
ttf-iosevkaterm-nerd \
ttf-jetbrains-mono-nerd \
ttf-lekton-nerd \
ttf-liberation-mono-nerd \
ttf-lilex-nerd \
ttf-meslo-nerd \
ttf-monofur-nerd \
ttf-monoid-nerd \
ttf-mononoki-nerd \
ttf-mplus-nerd \
ttf-nerd-fonts-symbols \
ttf-nerd-fonts-symbols-common \
ttf-nerd-fonts-symbols-mono \
ttf-noto-nerd \
ttf-profont-nerd \
ttf-proggyclean-nerd \
ttf-roboto-mono-nerd \
ttf-sharetech-mono-nerd \
ttf-sourcecodepro-nerd \
ttf-space-mono-nerd \
ttf-terminus-nerd \
ttf-tinos-nerd \
ttf-ubuntu-mono-nerd \
ttf-ubuntu-nerd \
ttf-victor-mono-nerd \
visual-studio-code-bin \
vlc \
xcape \
xdg-desktop-portal-gtk \
xorg-setxkbmap \
xorg-xinit \
xorg-xkbcomp \
xorg-xmessage \
xorg-xmodmap \
xorg-xprop \
xorg-xrandr \
xorg-xrdb \
xorg-xset \
xorg-xsetroot \
xsettingsd \
xss-lock \
zoxide \
zsh

