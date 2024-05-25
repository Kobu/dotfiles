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
alias ls='ls --color=tty'
alias grep='grep --color -n'
alias sed="sed -E"

# alias for better handling of dotfile
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# aliases for easier copying/pasting to system clipboard
alias c="xclip -selection clipboard"
alias p="xclip -selection clipboard -o"

# cd into the coding folder
alias coding="cd ~/coding"

# open nvim in dev mode
dvim(){
  XDG_CONFIG_HOME=~/coding/dotfiles/.config/ nvim $1
}

# function to create a directory and cd into it
mkcd(){
  mkdir $1 && cd $1
}

git_branch() {
     if git status &> /dev/null ; then
         echo -e ':\e[0;35m'$(git branch --show-current)'\e[m'
    fi

    # echo ":" $(git branch --show-curemt 2> /dev/null)
}

# show currently stopped jobs next to the command prompt
cur_jobs () {
    if [ ! -z "$(jobs)" ] ; then
        echo -n ' ('

        # 1. print all currently paused jobs
        # 2. get names of the paused jobs and add a space at the end
        # 3. replace newlines with commas
        # 4. ignore last two chars - a joining comma and a space
        jobs -s \
            | sed "s/.*Stopped *(.*)/\1 /"  \
            | tr  '\n' ',' \
            | head -c -2

        echo -n ')'
    fi
}
# f"{time} [kobu@arch:{PWD}]"" 
PS1=' \A \[\e[34m\][\[\e[m\]\[\e[35m\]\u\[\e[m\]\[\e[34m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\]:\[\e[36m\]\W\[\e[m\]\[\e[32m\]$(git_branch)\[\e[34m\]]\[\e[m\]\[\e[32;47m\]\[\e[m\]$(cur_jobs)\n\011> '

# run fastfetch at every terminal open
fastfetch

# make MUNI directory globally available
export MUNI=/home/kobu/muni
# export current semster
export CURENT_SEMESTER="6sem"
# alias for cd-ing to the folder of the current semester
alias semester='cd $MUNI/$CURENT_SEMESTER'

# make every course file in the currect semester globally available
for course in $MUNI/$CURENT_SEMESTER/*; do
    alias "$(basename $course)"="cd $course"
done


export EDITOR="nvim"
export PATH="$PATH:/home/kobu/.local/bin"

export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# move the history file to XDG_DATA_HOME
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

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
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# used by gpg to work correctly
export GPG_TTY=$(tty)

# ghcup: used by nvim LSP to correctly setup haskell
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

# postgresql: .psql_history
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"

# nodejs: .node_relp_history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history

# ghcup: .ghcup
export GHCUP_USE_XDG_DIRS=true

# cabal: .cabal
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_DATA_HOME"/cabal

# bash: .bash_history
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export HISTIGNORE="fg"

export BROWSER=wslview

source /usr/share/nvm/init-nvm.sh

