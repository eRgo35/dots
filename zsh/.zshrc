# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


###############################################################################################################################
#                                                             Initialization                                                  #
###############################################################################################################################


# Setting up Zinit, if not installed then clone it in.
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit!
source "${ZINIT_HOME}/zinit.zsh"

#source external files
test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)
source ~/.aliases
autoload -U colors
colors
autoload zcalc
autoload zmv
autoload zed

###############################################################################################################################
#                                                          History Settings                                                   #
###############################################################################################################################

HISTFILE=~/.zsh_history   #History file - zsh in name, to differentiate, idk
HISTSIZE=1000010000   #1B history entries - storage space is cheap :)
SAVEHIST=1000000000   #A margin to store some duplicates
setopt INC_APPEND_HISTORY_TIME  #Black magic, honestly - history nonblockingly gets written to histfile, but separate sessions keep their separate histories
setopt HIST_VERIFY    #Forces user to confirm banging commands from history (!! pastes previous command to prompt)
setopt HIST_IGNORE_DUPS   #Ignores duplicates of commands directly before
setopt HIST_EXPIRE_DUPS_FIRST #Pretty self-explanatory, really
setopt HIST_IGNORE_SPACE  #Ignores commands with preceding space
setopt EXTENDED_HISTORY   #Appends timestamps and run duration to the history file

setopt completealiases
setopt interactivecomments

#bash-like word character detection (alphanumeric only)
autoload -U select-word-style
select-word-style bash

# Load powerlevel10k theme
zinit ice depth"1"                   ##git clone depth
zinit light romkatv/powerlevel10k

zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use

zinit ice wait lucid
zinit light laggardkernel/zsh-thefuck

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# forgit
zinit ice wait lucid
zinit load 'wfxr/forgit'

zinit snippet ~/.zsh_compl/zoxide
zinit snippet OMZL::completion.zsh

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
zinit pack"binary" for fzf
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
