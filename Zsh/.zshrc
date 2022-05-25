#!/usr/bin/zsh

# Profiling shell load time; run `zprof` to get profiling info ('self' % column most important)
zmodload zsh/zprof

###############  Variables  ######################

# Colors
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

export CACHEDIR=~/.cache/
export ZSHUPDATEDFILE=/tmp/zsh.updated45a4586f367a83116277a3e81b87756b6ba1b6c9
export XDG_CONFIG_HOME=$HOME/.config/
export NODE_OPTIONS=--max-old-space-size=8192

##############  Zsh Options  #####################

setopt HIST_IGNORE_SPACE
# NOTE: Sourcing completion_settings.zsh slows down shell startup significantly
# source ~/.config/zsh/completions/completion_settings.zsh

# Don't ask for confirmation before `rm path/*`
setopt rm_starsilent

# Turn off all beeps
unsetopt BEEP

###############  P10K  ###########################

ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit $HOME/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###############  Pyenv  ##########################

# Load pyenv; must do that before loading the plugin
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export ZSH_PYENV_VIRTUALENV=true
export ZSH_PYENV_QUIET=false
source ~/.config/zsh/completions/pyenv.zsh
# eval "$(pyenv init --path)"

###############  OMZ  ############################

# Oh-My-Zsh updates
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 14

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Command execution time shown in the history command output.
HIST_STAMPS="dd.mm.yyyy"

# Plugins
plugins=(
    git
    pass
    pip
    pyenv
    zsh-autosuggestions
    zsh-vi-mode
    fast-syntax-highlighting
    evalcache
)

# Path to the oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh


###############  Path Extensions  ################

# Binary paths
path+=('/usr/local/bin')
path+=("$HOME/.local/share/go/bin")
path+=("$HOME/.local/bin")
path+=("$HOME/.local/share/gem/ruby/3.0.0/bin/")

# Perl
PATH="$HOME/.local/share/perl5/bin${PATH:+:${PATH}}"
PERL5LIB="$HOME/.local/share/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/.loca/share/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/.local/share/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/.local/share/perl5"; export PERL_MM_OPT;

export PATH

XDG_DATA_HOME=$HOME/.local/share

# Dynamic library path i.e. where the OS finds *.so files
LD_LIBRARY_PATH=/usr/lib
export LD_LIBRARY_PATH

# Go Programs
GOPATH="$HOME/.local/share/go"
export GOPATH

###############  System Utils  ###################

# Update i3blocks package status
alias updatei3barchupdate="pkill -SIGRTMIN+11 i3blocks"

# Backup to external drive, Github, and timeshift
function backup_full {
    sudo big_backup
    printf "\n"
    small_backup
}

# This evaluates to `pacman ...` or `sudo pacman ...` if needed
function pm {
    case $1 in
        -S | -D | -S[^sih]* | -R* | -U*)
            sudo pacman --noconfirm "$@" ;;
        *)
            pacman --noconfirm "$@" ;;
    esac
    updatei3barchupdate
}

alias pmb="backup_full; printf '\n'; pm $@"

function update {
    yay --ask --combinedupgrade -Syu
    updatei3barchupdate
}

# Shutdown/Reboot + backup
alias sdown="backup_full; shutdown now"
alias rboot="backup_full; systemctl reboot"

# Rebuild grub
alias grubmk="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias npmi="npm i --prefix $HOME/.local/share/npm"

function mine {
    sudo xmrig --cuda --donate-level 0 -o de.haven.herominers.com:1110 -u $(pass havenprotocol.org/address) -p my_xmrig_worker -a cn-heavy/xhv -k
}

alias sc="kitty +kitten ssh cluster"

# Full system scan
function full_clamscan () {
    clamscan --max-filesize=4000M --max-scansize=4000M --move=/home/matteo/.local/share/clamscan/quarantine  -l /home/matteo/.local/share/clamscan/$(date --iso-8601=date).log --recursive --infected --exclude-dir='^/sys|^/dev' /
}

# Adjust webcam brightness (takes percent)
function webcam_list_options {
    v4l2-ctl -d /dev/video0 --list-ctrls
}

# Adjust webcam brightness (takes percent)
function webcam_configure {
    v4l2-ctl -d /dev/video0 --set-ctrl=brightness=180,contrast=32,saturation=40,white_balance_temperature_auto=1,gain=180,power_line_frequency=2,sharpness=200,backlight_compensation=1,exposure_auto_priority=1
}

# Time zsh startup time
function timezsh {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do time $shell -i -c exit; done
}

###############  Bluetooth  ######################

alias blue="bluetoothctl connect"
alias blued="bluetoothctl disconnect"

function bluer {
    sudo systemctl restart bluetooth
    blue $(history | grep '  blue [29CE]' | tail -1 | sed 's/.*  blue //')
    configure_keyboard
}

function airc {
    blue 94:16:25:50:A2:58 &
    blue E4:90:FD:40:B9:06 &
}

function aird {
    blued 94:16:25:50:A2:58 &
    blued E4:90:FD:40:B9:06 &
}

###############  Beauty  #########################

alias rsyncp="rsync -ah --info=progress2 --no-i-r"

alias cat='bat --style header --style rules --style snip --style changes --style header'

alias ls='exa -l --color=always --group-directories-first --icons' # preferred listing
alias la='exa -la --color=always --group-directories-first --icons'  # all files and dirs
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"

alias du='dust'
alias df='duf'

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Mcfly (better history)
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2
export MCFLY_INTERFACE_VIEW=TOP
export MCFLY_RESULTS_SORT=LAST_RUN
alias h="mcfly search"

alias htop="btm -c"
alias ps="procs"
alias http="xh" # For http requests
alias benchmark="hyperfine"

###############  VI MODE  ########################

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
fi
}
zle -N zle-keymap-select
zle-line-init() {
zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

###############  SPEED  ##########################

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Execute current suggestion with ctrl+j, accept with ctrl-l
bindkey "^l" autosuggest-accept
bindkey "^j" autosuggest-execute

execute-clear-screen () { echo; clear; zle redisplay }
zle -N execute-clear-screen
bindkey '^h' execute-clear-screen

bindkey -s "^x" 'ls\n'

# Use aliases with sudo
alias sudo='sudo '

# Once key stroke cd
alias c='cd'

# Open files easily
function o {
    mimeopen -n $@ >/dev/null 2>/dev/null &
    disown
}

# Sorted du
alias dus="du -hs $@ | sort -h"
alias dusl="du -hs * | sort -h"

# Translation
function tl {
    tmp="$@"; trans "$tmp"
}

# Copying and pasting from command line
alias cpy="xclip -sel c <"
alias pst="xclip -sel c -o >"

# Run vifm with image and video preview support
alias vifm="$HOME/.local/bin/vifmrun"

# Fast tree
alias t="tree -C -a --dirsfirst"

# Ripgrep with syntax highlighting
function hg {
    command hgrep --theme ayu-mirage --term-width "$COLUMNS" "$@" | less -R
    test "${pipestatus[1]}" -eq 0
}

# ls after cd
function cl {
    new_directory="$*";
    if [ $# -eq 0 ]; then
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && t -L 2
}

# find things
function f {
    tmp="$@"; sudo find / -iname "*$tmp*" -exec ls --color -d {} \;
}

function fl {
    tmp="$@"; find . -iname "*$tmp*" -exec ls --color -d {} \;
}

function pg {
    tmp="$@"; pdfgrep -r --cache --color auto --ignore-case --regexp="$tmp"
}

function mv_and_replace {
    mv $1 $2
    rec_replace ~/Sync/University/SoSe22ODSPRMVA/implementation/big_brother $1 $2
}
function rec_replace {
    find $1 \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i "s/$2/$3/g"
}

alias i="/home/matteo/.pyenv/versions/ml/bin/ipython --no-confirm-exit"

# Make vim play well with virtual environments
# Solution from here: https://vi.stackexchange.com/questions/7644/use-vim-with-virtualenv/34996#34996

alias v=nvim

alias pc="pass -c"
alias poc="pass otp -c"

alias vime="nvim $HOME/.config/nvim/init.vim"
alias vimed="nvim $HOME/.config/nvim/"
alias vimep="nvim $HOME/.config/nvim/vim-plug/plugins.vim"
alias vimec="nvim $HOME/.config/nvim/coc-settings.json"

alias vifme="nvim $HOME/.config/vifm/vifmrc"

alias zshe="nvim $HOME/.zshrc; exec zsh"

alias i3e="nvim $HOME/.config/i3/config"
alias i3be="nvim $HOME/.config/i3blocks/config"

alias kittye="nvim $HOME/.config/kitty/kitty.conf; killall -s SIGUSR1 kitty"

alias xinite="sudo nvim $HOME/.xinitrc"

alias backupe="nvim $HOME/Sync/System/Backup/small_backup.sh"

alias mutt="neomutt "
alias mutte="nvim $HOME/.config/mutt/muttrc"

alias vt="nvim *.tex"
alias vtt="nvim *.tex -c ':LLPStartPreview'"

alias vp="nvim *.py"

alias gu="git add -u; git commit -m \"$@\"; git push"
alias gul="git add -u; git commit-status; git push"
alias gcos="git commit-status"

function smbe {
    sudo nvim /etc/samba/smb.conf
    sudo smbcontrol all reload-config
    sudo systemctl restart smb nmb
}

function s {
    pathpattern="."
    for substr in "$@"
    do
        pathpattern+="/*$substr*"
    done
    echo $pathpattern
    pathres=$(find . -maxdepth $# -type d -ipath "$pathpattern" | head -n 1)
    if [[ $pathres != "" ]]; then
        cd "$pathres"
        t -L 2
    fi
}

# Fast note with markdown
function fn {
    DATE=$(date +%Y-%m-%d)
    echo "# Notes made on the $DATE" >> $DATE.md
    nvim $DATE.md
}

###############  University  #####################

function clean_course {
    echo "$1" | sed 's/\[//g; s/\]//g'
}

function u {
    WORK_DIR=/home/matteo/Sync/University
    ISISDL_DIR=/home/matteo/Isis
    unset COURSE
    unset COURSE_CLEAN
    argc=${#1}
    course=${1:0:1}
    subdir=${1:1:1}

    if [[ $argc -ge 3 ]]; then
        exercise_num=${1:2:$(( $argc - 2 ))}
    else
        exercise_num=0
    fi

    case $course in
        a* )
            COURSE='ABSSS22' ;;
        e* )
            COURSE='SoSe22EITS' ;;
        o* )
            COURSE='SoSe22ODSPRMVA' ;;
        k* )
            COURSE='S22KI' ;;
        M* )
            COURSE='SoSe2021ML2' ;;
        m* )
            COURSE='SoSe2022ML2' ;;
    esac

    COURSE_CLEAN=$(clean_course $COURSE)

    case $argc in
        1 )
            cl "$ISISDL_DIR/$COURSE/" ;;
        2 )
            case $subdir in
                s )
                    cl "$WORK_DIR/$COURSE_CLEAN/Solutions/" ;;
                . )
                    cl "$WORK_DIR/$COURSE_CLEAN/" ;;
                v )
                    cl "$ISISDL_DIR/$COURSE/Videos/" ;;
                *)
                    cl "$ISISDL_DIR/$COURSE/"
            esac
            ;;
        [34] )
            cl $(find $WORK_DIR/$COURSE_CLEAN/Solutions -maxdepth 1 -type d -name "*$exercise_num" | head -n 1)
            ;;
        *)
            cl $ISISDL_DIR/$COURSE
            ;;
    esac
}

# Extract zipped, signed machine learning 1 notebooks
function ml1_extract {
    sha=$(shasum $1 | sed 's/\s.*$//')
    gpg -d $1 > /tmp/$sha
    unzip /tmp/$sha -d .
}

function latex_setup {
    mkdir -p {out,images,sections/out}
    ln -s ../images sections/images
    ln -s ../general.sty sections/general.sty
    ln -s ../specific.sty sections/specific.sty
    ln $HOME/Sync/Programs/Self/latex/Packages/general.sty general.sty
    cp $HOME/Sync/Programs/Self/latex/Packages/specific.sty specific.sty
    cp $HOME/Sync/Programs/Self/latex/Templates/Generic/main.tex main.tex
}

# latex_cleanup
function lcl {
    rm -f out/*
}

# latex compile
function lco {
    latexmk -pdf -output-directory=out $@
}

# latex clean compile
function lcc {
    lcl; lco $1
}

# latex compile all
function lca {
    parallel latexmk -pdf -output-directory=out {} ::: **/*.tex
}

# latex clean compile all
function lcca {
    lcl; lca
}

function jl {
    jupyter-lab $1
}

function jn {
    jupyter notebook $1
}

###############  Techlabs  #######################

function mgmt_onboarding {
    firefox -url "https://www.notion.so/techlabs/c30ffb07ffe5419caa51a7b36ab208d3?v=309bfe26069749228921a296d7d99eee" "https://www.notion.so/techlabs/Non-Disclosure-Agreement-NDA-5e844ea9f1944036a0a103a463e1c2ae" "https://admin.google.com/u/1/ac/users?action_id=ADD_USER" "https://admin.google.com/u/1/ac/groups/03whwml41tspvjp" "https://admin.google.com/u/1/ac/groups/035nkun22iwi22l" "https://techlabs-mgmt.slack.com/admin" "https://techlabs-mgmt.slack.com/admin/user_groups" "https://techlabs-community.slack.com/admin" "https://techlabs-community.slack.com/admin/user_groups"
    log_info "Don't forget to add the new member to NOTION and write an EMAIL!"
}

###############  VPN  ############################


alias updatei3bip="pkill -SIGRTMIN+12 i3blocks"
alias delayed_updatei3bip="( ( sleep 3 && updatei3bip ) & )"


# Connect to the VPN of Technische Universität Berlin
# alias vpnt='openconnect https://vpn.tu-berlin.de/ -b'
function vpnt {
    vpnnd >/dev/null
    sudo openconnect https://vpn.tu-berlin.de/ -q -b -u matteo
    delayed_updatei3bip
}

# Disconnect from the VPN of Technische Universität Berlin
function vpntd {
    sudo pkill openconnect
    delayed_updatei3bip
}

# Connect to the VPN of NordVPN
function vpnn {
    if [[ $(pidof openconnect >/dev/null && echo $?) == 0 ]]; then
        vpntd >/dev/null
    fi
    if [[ $(systemctl status nordvpnd) != *"active (running)"* ]]; then
        sudo systemctl start nordvpnd.service nordvpnd.socket
    fi
    if [[ $(nordvpn connect) == *"not logged in"* ]]; then
        nordvpn login
    fi
    nordvpn connect $@
    delayed_updatei3bip
}

# Disconnect from NordVPN
function vpnnd {
    nordvpn disconnect
    delayed_updatei3bip
}

###############  Raspberry  ######################

BERRYIP="192.168.0.242"

function berryd {
    rdesktop -g 1920x1080 -5 -K -r clipboard:CLIPBOARD -u matteo $BERRYIP -p $(pass raspberry_pi/matteo)
}

function berrys {
    sshpass -p $(pass raspberry_pi/matteo) ssh -Y matteo@$BERRYIP
}

###############  Exports  ########################

# To enable importing gpg keys via qr codes
# See: https://wiki.archlinux.org/title/Paperkey
export EDITOR=nvim

# Make gpg work, check `man gpg-agent`
export GPG_TTY=$TTY

# Eliminate delay on cancelling mutt operations with <ESC>
export ESCDELAY=0

# To make much mailsync work
export MBSYNCRC=$HOME/.mbsyncrc
export PASSWORD_STORE_DIR=$HOME/.password-store
export NOTMUCH_CONFIG=$HOME/.notmuch-config
export GNUPGHOME=$HOME/.gnupg/

###############  Docker  #########################

alias dbl="sudo docker build"
alias drn="sudo docker run -d --rm --gpus all"
alias dxe="sudo docker exec -it"
alias dps="sudo docker ps"
alias dkl="sudo docker kill"

###############  Mutt  ###########################

function start_mailsync_daemon {
    # First kill all running instances,
    if [[ $(pgrep -f mailsync-daemon) ]]; then
        parallel kill ::: $(pgrep -f mailsync-daemon)
    fi

  # then start the new daemon
  mailsync_daemon
}

###############  R  ##############################

R_LIBS=$HOME/.local/share/R/lib/
export R_LIBS

###############  Python  #######################

fpath+=$HOME/.local/share/conda-zsh-completion/
compinit conda

alias activate="source *_env/bin/activate"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYTHONPYCACHEPREFIX=$CACHEDIR/python/
export MYPY_CACHE_DIR=$CACHEDIR/mypy/

function pyasc_setup {
    python -m jupyter_ascending.scripts.make_pair --base $1
}

function pyasc_sync {
    python -m jupyter_ascending.requests.sync --filename $1
}

function pyasc_edit {
    python -m jupyter_ascending.requests.sync --filename $1
    nvim $1
}

function python_setup {
    echo "run: \n\tpython3 \$(ARGS)" > Makefile
}

###############  Deep Learning  ##################

function csv_to_unix {
    tr -d '"\15\32' < $1 > unix_$1
}

function pyasc_create {
    python -m jupyter_ascending.scripts.make_pair --base $1
}

function pyasc_sync {
    python -m jupyter_ascending.requests.sync --filename $1
}

function pyasc_setup {
    pyasc_create $1
    pyasc_sync $1.py
}

function pyasc_setup_run {
    pyasc_create $1
    pyasc_sync $1.py
    jupyter notebook $1.ipynb
}


###############  C++

# Generate compile commands cpp_compile_commands <src-dir> <build-dir>
function cpp_compile_commands {
    cmake -S $1 -B $2 -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
    mv $2/compile_commands.json $2/..
}

# Compile and run
function cpp_cmake_run {
    cmake -S src -B release ; make --directory=release ; ./release/main images/lena.jpg $@
}

# Compile and run
function cpp_cmake_test {
    cmake -DCMAKE_BUILD_TYPE=debug -S src -B debug ; make --directory=debug ; gdb ./debug/unit_test -ex "source debug/debug_commands_test.gdb"
}

# Compile and run with gdb and gdb commands
function cpp_cmake_debug {
    cmake -DCMAKE_BUILD_TYPE=debug -S src -B debug ; make --directory=debug ; gdb ./debug/main -ex "source debug/debug_commands.gdb"
}

###############  Last minute  ####################

# Ask for update after startup
if ! [[ -f "$ZSHUPDATEDFILE" ]]; then
    BOOTTIME=$(who -b | sed 's/.*\(..:..\)$/\1/' | sed 's/://')
    NOWTIME=$(date +%H%M)
    let "PREVMIN = $NOWTIME - 1"
    if ! [[ ($BOOTTIME = $NOWTIME) && ($BOOTTIME = $PREVMIN) ]]; then
        read -q "?Wanna copy gpg password in buffer? "
        if [[ $REPLY =~ [Yy] ]]; then
            pass -c master-password
        fi
        echo -e "\033[2K"

        # read -q "?Wanna start mailsync-daemon "
        # if [[ $REPLY =~ [Yy] ]]; then
        #     start_mailsync_daemon
        # fi
        # echo -e "\033[2K"

        touch $ZSHUPDATEDFILE
    fi
fi

_evalcache direnv hook zsh
_evalcache mcfly init zsh
_evalcache zoxide init zsh
_evalcache pyenv init --path
