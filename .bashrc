# ~.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export EDITOR='nvim'

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# Then extra stuff to append history from all tmux windows:
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
#export PROMPT_COMMAND='echo -ne "\033]0;YOUR TITLE GOES HERE\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

# export BROWSER=firefox # for default xdg-open in /bin/user/xdg-open

# https://github.com/wting/autojump
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
alias code="cd /data/mega/code/repos"

# Source autojump, so it works in plain bash, as well as tmux
if [ -f /etc/profile.d/autojump.bash ]; then
    . /etc/profile.d/autojump.bash
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Essential line to get tmux to work with solarized:
export TERM=screen-256color-bce

# Add custom colour scheme produced from http://ciembor.github.io/4bit/#
# source ../solarized.sh

# Nvim-r-plugin requires its own line in .vimrc to achieve this
alias R='R --no-save --no-restore --quiet'
alias sudo='sudo ' # ensures that sudo R loads .Rprofile

# shell promopt (31m = red, 32m = green)
export PS1='\[\e[1;32m\]\w\$\[\e[0m\] '

# read ~/.dircolors:
d=.dircolors
test -r $d && eval "$(dircolors $d)"

# thefuck
eval "$(thefuck --alias)"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# from @karpfen:
function run {
    if [ -z "$1" ]; then
        echo "Usage: run <file_name>"
    else
        if [ -f $1 ] ; then
            xdg-open $1 &> /dev/null
        else
            echo "$1 - file does not exist"
        fi
    fi
}

function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    else
        if [ -f $1 ] ; then
            # NAME=${1%.*}
            # mkdir $NAME && cd $NAME
            case $1 in
                *.tar.bz2) tar xvjf ./$1 ;;
                *.tar.gz) tar xvzf ./$1 ;;
                *.tar.xz) tar xvJf ./$1 ;;
                *.lzma) unlzma ./$1 ;;
                *.bz2) bunzip2 ./$1 ;;
                *.rar) unrar x -ad ./$1 ;;
                *.gz) gunzip ./$1 ;;
                *.tar) tar xvf ./$1 ;;
                *.tbz2) tar xvjf ./$1 ;;
                *.tgz) tar xvzf ./$1 ;;
                *.zip) unzip ./$1 ;;
                *.Z) uncompress ./$1 ;;
                *.7z) 7z x ./$1 ;;
                *.xz) unxz -k ./$1 ;;
                *.exe) cabextract ./$1 ;;
                *) echo "extract: '$1' - unknown archive method" ;;
            esac
        else
            echo "$1 - file does not exist"
        fi
    fi
}

function title () {
    echo -ne "\033]0;${1}\007"
}

# export VIMRUNTIME=/usr/share/vim/vim91

# for js V8; see http://blog.scaleprocess.net/building-v8-on-arch-linux/
export PATH=/usr/local/lib/depot_tools:"$PATH"  
# for ruby; see https://wiki.archlinux.org/index.php/ruby#Setup
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
# for rust
export PATH=~/.cargo/bin:"$PATH"
# for pre-commit
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.gitbin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:$HOME/miniconda/bin"

# change background color for directories, because some directories had blue
# font on dark green background which were illegible.
# https://linuxhint.com/ls_colors_bash/
# Use $ dircolors -p to print interpretable version of all variables
# and "$ dircolors -b >> .bashrc" to append to here. Both were changed to red
# with no (= white) background):
# - "tw" = "STICKY_OTHER_WRITABLE": "30;42" -> "31;107"
# - "ow" = "OTHER_WRITABLE": "34;42" -> "31;107"
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=31;107:ow=31;107:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# gtags exports
# https://cvs.savannah.gnu.org/viewvc/global/global/plugin-factory/PLUGIN_HOWTO.pygments?revision=1.6&view=markup
# export these variables to extend parsing to all ctags-supported languages -
# makes 'gtags' much slower, and makes little difference to pkgstats results
# anyway.
#export GTAGSCONF=/usr/local/share/gtags/gtags.conf
#export GTAGSLABEL=pygments

# ------------------------------------
#     a few colours
# ------------------------------------

BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'

PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m' # No Color

# ------------------------------------
#     startup
# ------------------------------------

OS="$(cat /etc/os-release | grep 'PRETTY_NAME' | sed 's/^.*=//g')"
OS="$(echo $OS | sed 's/\"//g')"
CPU="$(lscpu | grep 'Model name' | tr -s ' ' | cut -d ' ' -f 5-8)"
NCPUS="$(nproc --all)"
PID="$(cat /proc/$$/stat | cut -d \  -f 4)"
CONSOLE="$(ps -o cmd -f -p ${PID} | tail -1 | sed 's/ .*$//')"
#HOST="$(hostnamectl | grep 'hostname' | sed 's/^.: //')"
HOST="$(nmcli general hostname)"
KERNEL="$(uname -srm | cut -d \  -f 2)"
NPKGS="$(pacman -Q | wc -l)"
NRPKGS="$(Rscript -e 'nrow(installed.packages())' | tr -s ' ' | cut -d ' ' -f 2)"
# DSRPKGS="$(du -sh /usr/local/lib/R/site-library | cut -f 1)"
DSRPKGS="$(du -sh /usr/lib/R/library | cut -f 1)"

MEMUSED="$(vmstat -s | grep 'used memory' | tr -s ' ' | cut -d ' ' -f 2)"
MEMTOT="$(vmstat -s | grep 'total memory' | tr -s ' ' | cut -d ' ' -f 2)"
MEMPC=$(echo "scale=2;100*$MEMUSED/$MEMTOT" | bc -l)
MEMUSED=$(echo "scale=2;$MEMUSED/1024/1024" | bc -l)
MEMTOT=$(echo "scale=2;$MEMTOT/1024/1024" | bc -l)
DSROOTSIZE=$(df -h / | tail -n 1 | tr -s ' ' | cut -d ' ' -f 2)
DSROOTUSED=$(df -h / | tail -n 1 | tr -s ' ' | cut -d ' ' -f 3)
DSROOTPC=$(df -h / | tail -n 1 | tr -s ' ' | cut -d ' ' -f 5)
DSDATASIZE=$(df -h /data | tail -n 1 | tr -s ' ' | cut -d ' ' -f 2)
DSDATAUSED=$(df -h /data | tail -n 1 | tr -s ' ' | cut -d ' ' -f 3)
DSDATAPC=$(df -h /data | tail -n 1 | tr -s ' ' | cut -d ' ' -f 5)

HLINE=$(printf '%40s\n' | tr ' ' -)
#printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

# https://texteditor.com/multiline-text-art/

echo -e ""
echo -e "$GREEN ████████╗██╗  ██╗███████╗    ██████╗  ██████╗ ██╗  ██╗ "
echo -e "$GREEN ╚══██╔══╝██║  ██║██╔════╝    ██╔══██╗██╔═══██╗╚██╗██╔╝ "
echo -e "$GREEN    ██║   ███████║█████╗      ██████╔╝██║   ██║ ╚███╔╝  "
echo -e "$GREEN    ██║   ██╔══██║██╔══╝      ██╔══██╗██║   ██║ ██╔██╗  "
echo -e "$GREEN    ██║   ██║  ██║███████╗    ██████╔╝╚██████╔╝██╔╝ ██╗ "
echo -e "$GREEN    ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ "
echo -e ""
echo -e "$BLUE                A                 $LIGHTBLUE\e[1m         OS: $NC $OS"
echo -e "$BLUE               ooo                $LIGHTBLUE\e[1m       Host: $NC $HOST"
echo -e "$BLUE              ooooo               $LIGHTBLUE\e[1m     Kernel: $NC $KERNEL"
echo -e "$BLUE             ooooooo              $LIGHTBLUE\e[1m        Cpu: $NC $CPU"
echo -e "$BLUE            ooooooooo             $LIGHTBLUE\e[1m      Ncpus: $NC $NCPUS"
echo -e "$BLUE           ooooo ooooo            $LIGHTGREEN$HLINE$NC"
echo -e "$BLUE          ooooo   ooooo           $LIGHTBLUE\e[1m     Memory: $NC $MEMUSED / $MEMTOT GB (${MEMPC}%)"
echo -e "$BLUE         ooooo     ooooo          $LIGHTBLUE\e[1m    Disk(/): $NC $DSROOTUSED / $DSROOTSIZE GB (${DSROOTPC})"
echo -e "$BLUE        ooooo       ooooo         $LIGHTBLUE\e[1mDisk(/data): $NC $DSDATAUSED / $DSDATASIZE GB (${DSDATAPC})"
echo -e "$BLUE       ooooo  $WHITE<oooooooooo>        $LIGHTGREEN$HLINE$NC"
echo -e "$BLUE      ooooo      $WHITE<oooooooo>       $LIGHTBLUE\e[1m   Packages: $NC $NPKGS"
echo -e "$BLUE     ooooo          $WHITE<oooooo>      $LIGHTBLUE\e[1m R Packages: $NC $NRPKGS ($DSRPKGS)"

bash /<path>/<to>/<system-scripts>/r-version.bash

export PATH="$PATH:$HOME/miniconda/bin"

# ---------- ONEFETCH START ----------
#
# https://github.com/o2sh/onefetch/wiki/getting-started
# With modifications to add extra separator line only if .bashrc is called at
# start of new terminal or pane.

export BASHRC_RUN="y"

# git repository greeter
last_repository=
check_directory_for_new_repository() {
    current_repository=$(git rev-parse --show-toplevel 2> /dev/null)

    if [ "$current_repository" ] && \
        [ "$current_repository" != "$last_repository" ]; then
            if [ -n "$BASHRC_RUN" ]; then
                echo -e ""
                echo -e "$GREEN ✩░░░░▒▒▒▒▓▓▓▓▆▆▆▆▅▅▅▅▃▃▃▃▂▂▂▂▁▁▁▁▁▁▁▁▂▂▂▂▃▃▃▃▅▅▅▅▆▆▆▆▓▓▓▓▒▒▒▒░░░░✩"
                echo -e ""
            fi
            onefetch
    fi
    last_repository=$current_repository
}
cd() {
    builtin cd "$@"
    check_directory_for_new_repository
}

# optional, greet also when opening shell directly in repository directory
# adds time to startup
check_directory_for_new_repository
# ---------- ONEFETCH END ----------
