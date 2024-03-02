export QT_STYLE_OVERRIDE="kvantum";

# Defaults
export TERM="kitty";
export TERMINAL="kitty";
export EDITOR='vim';
export BROWSER='firefox';

export BAT_THEME="Catppuccin-mocha";

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

# ~/ clean-up:
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # this line will break some DMs.
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export LESSHISTFILE="-"
export WGETRC="$HOME/.config/wget/wgetrc"
export INPUTRC="$HOME/.config/inputrc"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export ZDOTDIR="$HOME/.config/zsh"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss
export _Z_DATA="$XDG_DATA_HOME/z"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

export XDG_DESKTOP_DIR="$HOME/docs/desktop"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_TEMPLATES_DIR="$HOME/docs/templates"
export XDG_PUBLICSHARE_DIR="$HOME/docs/public"
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pics"
export XDG_VIDEOS_DIR="$HOME/videos"
# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

export WINIT_X11_SCALE_FACTOR=1;

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Less settings
if which less > /dev/null 2>&1;then
	export PAGER="less"
	export LESS="-R"
	# Don’t clear the screen after quitting a manual page.
	export MANPAGER='less -X';
fi

export FZF_DEFAULT_OPTS="--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796";

export PATH=$PATH:$HOME/.local/bin
