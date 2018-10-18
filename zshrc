# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

plugins=(git gem history history-substring-search terminalapp brew common-aliases osx rails)

# Load if exists
test -e $ZSH/oh-my-zsh.sh && source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

if type "brew" > /dev/null; then
	export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
fi

export EDITOR='vim'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

bindkey "[D" backward-word
bindkey "[C" forward-word

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

if type "thefuck" > /dev/null; then
	eval $(thefuck --alias)
fi

if type "jump" > /dev/null; then
	# brew install jump
	# https://github.com/gsamokovarov/jump
	eval "$(jump shell)"
fi

precmd() { tableflip; }

tableflip() {
	if [ $? -ne 0 ]; then
		echo "(╯°□°）╯︵ ┻━┻"\n
	fi
}

