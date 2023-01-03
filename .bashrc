#
# ~/.bashrc
#

# aise login helper
alias aisa='ssh xjakube1@aisa.fi.muni.cz'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# f"{time} [kobu@arch: {PWD}]"" 
PS1=' \A \[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\W\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]\[\e[m\] '

# run fastfetch at every terminal open
fastfetch

# make FIMUNI directory globally available
export FIMUNI=/home/kobu/coding/FIMUNI

# make every file in FIMUNI folder globally available
for el in $(ls $FIMUNI); do
	export $(echo $el)=$FIMUNI/$el
done

export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
