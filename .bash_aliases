alias wtf="source ~/.bashrc"
alias home="cd ~"
alias xf=startxfce4
alias code="cd <path>/<to>/<my>/<repos>"
#alias a="if [ -z \"${TMUX_PANE}\" ]; then tmux; else echo 'nope'; fi; vim aaa.Rmd"
alias a="vim aaa.Rmd"
alias l="tree -L 1"
alias t=tmux
alias clock='while true; do tput clear; date +"%H : %M : %S" | figlet ; sleep 1; done'
alias scan='nmcli dev wifi list'
alias l="tree -L 1"
alias gl="git ls-tree -r master"
alias battery="acpi -V | grep 'Battery'"
alias update="sudo pacman -Syu; yay -Syu"
alias updater="echo 'update.packages(ask=FALSE)' | sudo R --no-save -q"
alias rupdate="echo 'update.packages(ask=FALSE)' | sudo R --no-save -q"
alias backup="bash <path>/<to>/<my>/<rsync>/<script>"
alias bleach="sudo bleachbit"
alias fw="foundation watch"
alias f="ranger"
alias clip="dragon"
# netdata server:
# systemctl stop/start netdata
alias netdata="firefox http://127.0.0.1:19999/ &"
alias gitpush="bash <path>/<to>/<my>/<gitpush>/<script>"
alias incr="Rscript -e 'mpmisc::increment_dev_version()'"
alias todo="vim ~/Documents/todo"
alias sizes="du -sh * | sort -h"
alias rg="rg -T js -T html"
