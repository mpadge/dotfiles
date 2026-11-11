# ~/.bashrc
#
# Sections:
#   1. Environment (all shells)
#   --- everything below only runs in interactive shells ---
#   2. PATH
#   3. Shell options and history
#   4. Interactive environment (misc. variables, LS_COLORS)
#   5. Aliases
#   6. Functions
#   7. Tool integrations (completion, nvm, conda, thefuck, starship)
#   8. Startup banner and git repository greeter

# ------------------------------------
#     1. Environment (all shells)
# ------------------------------------

export BASE_PATH='/<some>/<where>'
export CLAUDE_CONFIG_DIR="$BASE_PATH/claude"
export EDITOR='nvim'
export NVIM_COLOUR_SCHEME="none"
export GH_TELEMETRY=false
export DO_NOT_TRACK=true

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

# ------------------------------------
#     2. PATH
# ------------------------------------

# Prepended
export PATH=/usr/local/lib/depot_tools:"$PATH" # js V8; see http://blog.scaleprocess.net/building-v8-on-arch-linux/
export PATH=~/.cargo/bin:"$PATH"               # rust
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$HOME/.opencode/bin:$PATH

# Appended
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin" # ruby; see https://wiki.archlinux.org/index.php/ruby#Setup
export PATH="$PATH:$HOME/.local/bin"                   # pre-commit
export PATH="$PATH:$HOME/.gitbin"
export PATH="$PATH:$HOME/bin/tree-sitter-parser"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/miniconda/bin"
export PATH="$PATH:$HOME/.radicle/bin" # Added by Radicle

# ------------------------------------
#     3. Shell options and history
# ------------------------------------

shopt -s checkwinsize # update LINES and COLUMNS after each command
shopt -s histappend   # append to history, don't overwrite it

HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:erasedups # no duplicate entries

# Append to history after each command, so all tmux windows share it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

# ------------------------------------
#     4. Interactive environment
# ------------------------------------

# Extension need to find boost for libosmium:
export LD_LIBRARY_PATH=/usr/include/boost/:$LD_LIBRARY_PATH

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# change background color for directories, because some directories had blue
# font on dark green background which were illegible.
# https://linuxhint.com/ls_colors_bash/
# Use $ dircolors -p to print interpretable version of all variables
# and "$ dircolors -b >> .bashrc" to append to here. Both were changed to red
# with no (= white) background):
# - "tw" = "STICKY_OTHER_WRITABLE": "30;42" -> "31;107"
# - "ow" = "OTHER_WRITABLE": "34;42" -> "31;107"
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=31;107:ow=31;107:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
export LS_COLORS

# ------------------------------------
#     5. Aliases
# ------------------------------------

if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'

# Nvim-r-plugin requires its own line in .vimrc to achieve this
alias R='R --no-save --no-restore --quiet'
alias sudo='sudo ' # ensures that sudo R loads .Rprofile

# Everything else lives in ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ------------------------------------
#     6. Functions
# ------------------------------------

# from @karpfen:
function run {
    if [ -z "$1" ]; then
        echo "Usage: run <file_name>"
    else
        if [ -f $1 ]; then
            xdg-open $1 &>/dev/null
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
        if [ -f $1 ]; then
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

function title() {
    echo -ne "\033]0;${1}\007"
}

# Remap 'git push' command:
git() {
    if [ "$1" = push ]; then
        shift
        git-push "$@"
    else
        command git "$@"
    fi
}

# ------------------------------------
#     7. Tool integrations
# ------------------------------------

# autojump (https://github.com/wting/autojump), so it works in plain bash as
# well as tmux
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh
if [ -f /etc/profile.d/autojump.bash ]; then
    . /etc/profile.d/autojump.bash
fi

# programmable completion (not needed if already enabled in /etc/bash.bashrc
# and /etc/profile sources /etc/bash.bashrc)
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# conda
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# thefuck
eval "$(thefuck --alias)"

# Prompt (PS1 is only a fallback; starship takes over).
# shell prompt (31m = red, 32m = green)
export PS1='\[\e[1;32m\]\w\$\[\e[0m\] '
# https://starship.rs
eval "$(starship init bash)"

# ------------------------------------
#     8. Startup banner and git repository greeter
# ------------------------------------

# All variables are local, so none leak into the interactive shell.
# https://texteditor.com/multiline-text-art/
startup_banner() {
    local BLUE='\e[0;34m'
    local GREEN='\e[0;32m'
    local LIGHTBLUE='\e[1;34m'
    local LIGHTGREEN='\e[1;32m'
    local WHITE='\e[1;37m'
    local NC='\e[0m' # No Color

    local OS CPU NCPUS HOST KERNEL NPKGS NRPKGS DSRPKGS
    local MEMUSED MEMTOT MEMPC
    local DSROOTSIZE DSROOTUSED DSROOTPC DSDATASIZE DSDATAUSED DSDATAPC
    local HLINE git_repository

    OS="$(cat /etc/os-release | grep 'PRETTY_NAME' | sed 's/^.*=//g')"
    OS="$(echo $OS | sed 's/\"//g')"
    CPU="$(lscpu | grep 'Model name' | tr -s ' ' | cut -d ' ' -f 5-8)"
    NCPUS="$(nproc --all)"
    HOST="$(nmcli general hostname)"
    KERNEL="$(uname -srm | cut -d \  -f 2)"
    NPKGS="$(pacman -Q | wc -l)"
    NRPKGS="$(Rscript -e 'nrow(installed.packages())' | tr -s ' ' | cut -d ' ' -f 2)"
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

    # Conditionally run separator only if in git repo, where one fetch will be
    # run below:
    git_repository=$(git rev-parse --show-toplevel 2> /dev/null)
    if [ "$git_repository" ]; then
        echo -e ""
        echo -e "$GREEN ✩░░░░▒▒▒▒▓▓▓▓▆▆▆▆▅▅▅▅▃▃▃▃▂▂▂▂▁▁▁▁▁▁▁▁▂▂▂▂▃▃▃▃▅▅▅▅▆▆▆▆▓▓▓▓▒▒▒▒░░░░✩"
        echo -e ""
    fi

    bash $BASE_PATH/system/scripts/r-version.bash
}
startup_banner

# ---------- ONEFETCH START ----------
#
# https://github.com/o2sh/onefetch/wiki/getting-started
# With modifications to add extra separator line only if .bashrc is called at
# start of new terminal or pane.

# git repository greeter
last_repository=
check_directory_for_new_repository() {
    current_repository=$(git rev-parse --show-toplevel 2> /dev/null)

    if [ "$current_repository" ] && \
        [ "$current_repository" != "$last_repository" ]; then
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
