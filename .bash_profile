#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# launch nowaster at startup
sh ~/utils/nowaster.sh  &>/dev/null &

# Start X at login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  # prime-offload
  # optimus-manager --no-confirm --switch nvidia
  # sudo prime-switch
  exec startx
fi
