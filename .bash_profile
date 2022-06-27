#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "${DISPLAY}" ] && [ -z "${TMUX}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi
