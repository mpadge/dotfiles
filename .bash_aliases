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
alias update="sudo pacman -Syu; paru -Syu"
alias updateable="paru -Qu"
alias updater="echo 'update.packages(ask=FALSE)' | sudo R --no-save -q"
alias rupdate="echo 'update.packages(ask=FALSE)' | sudo R --no-save -q"
alias backup="bash <path>/<to>/<my>/<rsync>/<script>"
alias bleach="sudo bleachbit"
alias fw="foundation watch"
alias f="ranger"
#alias clip="dragon"
# netdata server:
# systemctl stop/start netdata
alias netdata="firefox http://127.0.0.1:19999/ &"
alias gitpush="bash <path>/<to>/<my>/<gitpush>/<script>"
alias incr="Rscript -e 'mpmisc::increment_dev_version()'"
alias todo="vim ~/Documents/todo"
alias sizes="du -sh * | sort -h"
alias rg="rg --hidden --glob '!.git' -T js -T html -T css"
alias nfiles="ls | wc -l"
alias gitallfiles="git log --name-status | sed -ne 's/^A[^u]//p' | sort -u"
alias instloc="sudo Rscript -e 'remotes::install_local(path=\".\",upgrade=\"never\")'"
alias meta="Rscript -e 'codemetar::write_codemeta()'"
alias reprex="Rscript -e 'reprex::reprex()'"
alias timer="mongotimer"
alias clearcache="sudo paccache -r"
alias lastinstalls="grep -i installed /var/log/pacman.log"
alias emojis="firefox https://emcorrales.com/cheatsheets/github-emojis &"
alias issues="bash /<path>/<to>/issues.bash"
alias gn="bash /<path>/<to>/gh_notifications.bash"
alias pdf="bash /<path>/<to>/pdfinterm.bash"
alias open="bash /<path>/<to>/git-origin-open-url.bash"
alias c="calcurse"
alias today="calcurse -s"
alias tomorrow="calcurse -d 2"
alias clip="xclip -sel c < "
alias stop="systemctl poweroff"
alias keymap="bash /<path>/<to>/keymap.bash"
alias sshd="bash /<path>/<to>/sshd.bash"
alias wifipassword="nmcli device wifi show-password"
alias debugr="bash /<path>/<to>/debug.bash"
alias default_browser="bash /<path>/<to>/default-browser.bash"
alias c="calcurse"
alias today="calcurse -s"
alias tomorrow="calcurse -d 2"
alias daily="bash /<path>/<to>/daily.bash"
alias bot="bash /<path>/<to>/openai.bash"
alias win-builder="Rscript -e 'mpmisc::win_builder_checks()'"
alias printer="bash /<path>/<to>/printer.bash"
