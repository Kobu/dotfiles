#
# ~/.bashrc
#

# aise login helper
alias aisa='ssh xjakube1@aisa.fi.muni.cz'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# recursively remove orphaned packages
alias p_orphans='sudo pacman -Qtdq | sudo pacman -Rns -'

# aggresively remove pacman cache
alias p_cache='sudo pacman -Scc && yay -Scc'

# remove journal
alias p_journals='sudo journalctl --vacuum-size=10M'

# add color to common commands
alias ls='ls --color=auto'
alias grep='grep --color -n'

# alias for better handling of dotfile
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# f"{time} [kobu@arch: {PWD}]"" 
PS1=' \A \[\e[32m\][\[\e[m\]\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\W\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32;47m\]\[\e[m\] '

# run fastfetch at every terminal open
fastfetch

# make FIMUNI directory globally available
export FIMUNI=/home/kobu/coding/FIMUNI

export PATH="$PATH:/home/kobu/.local/bin"

# make every file in FIMUNI folder globally available
for el in $(ls $FIMUNI); do
	export $(echo $el)=$FIMUNI/$el
done

export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# cargo: .cargo
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# gnupg: .gnupg
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# gtk-2: .gtkrc-2.0
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# less: .lesshst
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"

# mypy: .mypy_cache
export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"

# nuget: .nuget/packages
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

# openjdk: .java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# xorg-xauth: .Xauthority
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# npm: .npmrc
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/.npmrc"

# X11: .xinitrc
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

# rustup: .rushtup
export RUSTUP_HOME="XDG_DATA_HOME"/rustup
