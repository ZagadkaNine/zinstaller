#!/bin/sh
export ZDOTDIR=$HOME/.config/zsh

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt appendhistory
setopt EXTENDED_HISTORY

# add snap to path 
#path+=('/snap/bin')
path+=("$HOME/.scripts")
path+=("$HOME/.local/bin")
path+=("$HOME/.local/share/gem/ruby/3.0.0/bin")
path+=("$HOME/.npm-global/bin")

export path

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"
eval "$(starship init zsh)"

zsh_add_file "zsh-vim-mode"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"


# Plugins
# zsh_add_plugin "romkatv/powerlevel10k"
# zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
# zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

## Key-bindings
#bindkey -s '^o' 'ranger^M'
#bindkey -s '^f' 'zi^M'
#bindkey -s '^s' 'ncdu^M'
## bindkey -s '^n' 'nvim $(fzf)^M'
## bindkey -s '^v' 'nvim\n'
#bindkey -s '^z' 'zi^M'
#bindkey '^[[P' delete-char
#bindkey "^p" up-line-or-beginning-search # Up
#bindkey "^n" down-line-or-beginning-search # Down
#bindkey "^k" up-line-or-beginning-search # Up
#bindkey "^j" down-line-or-beginning-search # Down
#bindkey -r "^u"
#bindkey -r "^d"
#
## FZF 
#[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
#[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
#[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
#[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"
## export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
#compinit
#
## Edit line in vim with ctrl-e:
#autoload edit-command-line; zle -N edit-command-line
## bindkey '^e' edit-command-line
#
## TODO Remove these
#setxkbmap -option caps:escape
#xset r rate 210 40
#
## Speedy keys
#xset r rate 210 40

## Environment variables set everywhere
#export EDITOR="nvim"
#export TERMINAL="alacritty"
#export BROWSER="brave"
#
## For QT Themes
#export QT_QPA_PLATFORMTHEME=qt5ct
#
## remap caps to escape
#setxkbmap -option caps:escape
## swap escape and caps
## setxkbmap -option caps:swapescape
#

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Load Angular CLI autocompletion.
#source <(ng completion script) -e 
