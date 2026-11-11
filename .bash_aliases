alias wtf="source ~/.bashrc"
alias home="cd ~"
alias xf=startxfce4
alias code="cd $BASE_PATH/code/repos"
#alias a="if [ -z \"${TMUX_PANE}\" ]; then tmux; else echo 'nope'; fi; vim aaa.Rmd"
alias a="nvim aaa.Rmd"
alias l="tree -L 1"
alias t=tmux
alias clock='while true; do tput clear; date +"%H : %M : %S" | figlet ; sleep 1; done'
alias scan='nmcli dev wifi list'
alias l="tree -L 1"
alias la="eza -1 -l -a --total-size --no-permissions --no-user"
alias gl="git ls-tree -r master"
alias battery="acpi -V | grep 'Battery'"
alias update="bash $BASE_PATH/system/scripts/update.bash"
alias updateable="paru -Qu"
alias ghaupdate="bash $BASE_PATH/system/scripts/r-lib-actions.bash"
alias backup="bash $BASE_PATH/system/scripts/rsync.bash"
alias bleach="sudo bleachbit"
alias fw="foundation watch"
alias f="ranger"
#alias clip="dragon"
# netdata server:
# systemctl stop/start netdata
alias netdata="firefox http://127.0.0.1:19999/ &"
alias incr="Rscript -e 'mpmisc::increment_dev_version()'"
alias todo="nvim ~/Documents/todo"
alias sizes="du -sh * | sort -h"
alias rg="rg --hidden --glob '!.git' -T js -T html -T css"
alias nfiles="ls | wc -l"
alias gitallfiles="git log --name-status | sed -ne 's/^A[^u]//p' | sort -u"
alias instloc="sudo Rscript -e 'remotes::install_local(path=\".\",upgrade=\"never\")'"
alias meta="Rscript -e 'codemetar::write_codemeta()'"
alias reprex="Rscript -e 'reprex::reprex()'"
alias timer="mongotimer"
alias clearcache="sudo paccache -r; paru -Sc"
alias lastinstalls="grep -i installed /var/log/pacman.log"
alias emojis="firefox https://emcorrales.com/cheatsheets/github-emojis &"
alias issues="bash $BASE_PATH/system/scripts/issues.bash"
alias gn="bash $BASE_PATH/system/scripts/gh-notifications.bash"
alias cb="gn codeberg"
alias notifications="gn all"
alias commits="gn commits"
alias pdf="bash $BASE_PATH/system/scripts/pdfinterm.bash"
alias open="bash $BASE_PATH/system/scripts/git-open-url.bash"
alias c="calcurse"
alias today="calcurse -s"
alias tomorrow="calcurse -d 2"
alias clip="xclip -sel c < "
alias stop="systemctl poweroff"
alias keymap="bash $BASE_PATH/system/scripts/keymap.bash"
alias sshd="bash $BASE_PATH/system/scripts/sshd.bash"
alias wifipassword="nmcli device wifi show-password"
alias debugr="bash $BASE_PATH/system/scripts/debug.bash"
alias default_browser="bash $BASE_PATH/system/scripts/default-browser.bash"
alias c="calcurse"
alias today="calcurse -s"
alias tomorrow="calcurse -d 2"
alias daily="bash $BASE_PATH/system/scripts/daily.bash"
alias bot="bash $BASE_PATH/system/scripts/openai.bash"
alias win-builder="Rscript -e 'mpmisc::win_builder_checks()'"
alias printer="bash $BASE_PATH/system/scripts/printer.bash"
alias gparted="gksu gparted &"
alias screenshot="xwd -root -out screenshot.xwd && convert screenshot.xwd screenshot.png && rm screenshot.xwd"
alias search="bash $BASE_PATH/system/scripts/searxng.bash"
alias actions="bash $BASE_PATH/system/scripts/actions.bash"
alias lstt="ls -latr | bash $BASE_PATH/system/scripts/tte.bash"
cat_to_tte() {
	cat "$1" | bash $BASE_PATH/system/scripts/tte.bash
}
alias cattt='cat_to_tte'
alias paru-query='paru -Ssq $1'
alias vim='nvim'
alias o='opencode .'
alias r-lib='bash $BASE_PATH/system/scripts/r-lib-actions.bash'
alias opencodeclean='cp ~/.config/opencode/opencode.json ~/.config/.; rm -rf ~/.local/share/opencode/ ~/.cache/opencode/ ~/.config/opencode/'
rmterminalwhite() {
    sed -i 's/[[:space:]]*$//' "$1"
}
alias sg='ast-grep run -c ~/.config/ast-grep/sgconfig.yml'
alias runiv='Rscript $BASE_PATH/system/scripts/r-univ-checks.R'
alias aicosts='bunx ccusage'
alias workflow-checks='bash $BASE_PATH/system/scripts/gha-workflows.bash'
alias find-remote='bash $BASE_PATH/system/scripts/find-remote.sh'
alias random-password='bash $BASE_PATH/system/scripts/random-password.bash'
