export QT_STYLE_OVERRIDE="kvantum";

# Defaults
export TERM="kitty";
export TERMINAL="kitty";
export EDITOR='vim';
export BROWSER='firefox';

export BAT_THEME="Catppuccin-mocha";


# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

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
