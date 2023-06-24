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

###############################################################################################################################
#                                                          Keybinds                                                           #
###############################################################################################################################


# Make sure that the terminal is in application mode when zle is active, since only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
        function zle-line-init() {
                echoti smkx
        }
        function zle-line-finish() {
                echoti rmkx
        }
        zle -N zle-line-init
        zle -N zle-line-finish
fi

bindkey '\ew' kill-region                             # [Esc-w] - Remove chars from the cursor to the mark

if [[ "${terminfo[kpp]}" != "" ]]; then
	  bindkey "${terminfo[kpp]}" up-line-or-history       # [PageUp] - Up a line of history
fi
if [[ "${terminfo[knp]}" != "" ]]; then
	  bindkey "${terminfo[knp]}" down-line-or-history     # [PageDown] - Down a line of history
fi

if [[ "${terminfo[kcuu1]}" != "" ]]; then
	  bindkey "${terminfo[kcuu1]}" up-line-or-search      # start typing + [Up-Arrow] - fuzzy find history forward
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
	  bindkey "${terminfo[kcud1]}" down-line-or-search    # start typing + [Down-Arrow] - fuzzy find history backward
fi

if [[ "${terminfo[khome]}" != "" ]]; then
	  bindkey "${terminfo[khome]}" beginning-of-line      # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
	  bindkey "${terminfo[kend]}"  end-of-line            # [End] - Go to end of line
fi

bindkey ' ' magic-space                               # [Space] - do history expansion - !![space] pastes previous command, ![num][space] jumps to history entry

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [[ "${terminfo[kcbt]}" != "" ]]; then
	  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
	bindkey "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
	bindkey "^[[3~" delete-char
	bindkey "^[3;5~" delete-char
	bindkey "\e[3~" delete-char
fi


PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'


case "${TERM}" in
    cons25*|linux) # plain BSD/Linux console
        bindkey '\e[H'    beginning-of-line   # home
        bindkey '\e[F'    end-of-line         # end
        bindkey '\e[5~'   delete-char         # delete
        bindkey '[D'      emacs-backward-word # esc left
        bindkey '[C'      emacs-forward-word  # esc right
        ;;
    *rxvt*) # rxvt derivatives
        bindkey '\eOc'    forward-word        # ctrl right
        bindkey '\eOd'    backward-word       # ctrl left
        bindkey '\e\e[D'  backward-word     ### Alt left
        bindkey '\e\e[C'  forward-word      ### Alt right
        # workaround for screen + urxvt
        bindkey '\e[7~'   beginning-of-line   # home
        bindkey '\e[8~'   end-of-line         # end
        bindkey '^[[1~'   beginning-of-line   # home
        bindkey '^[[4~'   end-of-line         # end
        ;;
    *xterm*) # xterm derivatives
        bindkey '\e[H'    beginning-of-line   # home
        bindkey '\e[F'    end-of-line         # end
        bindkey '\e[3~'   delete-char         # delete
        bindkey '^[[C'    forward-word        # ctrl right
        bindkey '^[[D'    backward-word       # ctrl left
        bindkey '\eOC'    forward-word        # ctrl right
        bindkey '\eOD'    backward-word       # ctrl left
        bindkey '^[[1;3C' forward-word        # alt right
        bindkey '^[[1;3D' backward-word       # alt left
        # workaround for screen + xterm
        bindkey '\e[1~'   beginning-of-line   # home
        bindkey '\e[4~'   end-of-line         # end
        ;;
    screen)
        bindkey '^[[1~'   beginning-of-line   # home
        bindkey '^[[4~'   end-of-line         # end
        bindkey '\e[3~'   delete-char         # delete
        bindkey '\eOc'    forward-word        # ctrl right
        bindkey '\eOd'    backward-word       # ctrl left
        bindkey '^[[1;5C' forward-word        # ctrl right
        bindkey '^[[1;5D' backward-word       # ctrl left
        ;;
esac

#bash-like word character detection (alphanumeric only)
autoload -U select-word-style
select-word-style bash

# Load powerlevel10k theme
zinit ice depth"1"                   ##git clone depth
zinit light romkatv/powerlevel10k

zinit ice wait lucid
# zinit light MichaelAquilina/zsh-you-should-use

zinit ice wait lucid
zinit light laggardkernel/zsh-thefuck

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# forgit
zinit ice wait lucid
zinit load 'wfxr/forgit'

# zinit snippet ~/.zsh_compl/zoxide
zinit snippet OMZL::completion.zsh

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

eval "$(zoxide init zsh)"

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
zinit pack"binary" for fzf
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
