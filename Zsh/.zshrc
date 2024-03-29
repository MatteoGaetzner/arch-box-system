#!/usr/bin/zsh

# Profiling shell load time; run `zprof` to get profiling info ('self' % column most important)
# zmodload zsh/zprof

###############  Variables  ######################

export CACHEDIR=~/.cache/
export ZSHUPDATEDFILE=/tmp/zsh.updated45a4586f367a83116277a3e81b87756b6ba1b6c9
export XDG_CONFIG_HOME=$HOME/.config/
export NODE_OPTIONS=--max-old-space-size=8192
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export LESSCHARSET=utf-8
export TERM="xterm-kitty"

##############  Zsh Options  #####################

setopt HIST_IGNORE_SPACE

setopt NO_NOTIFY NO_MONITOR

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
    zsh-autosuggestions
    zsh-vi-mode
    fast-syntax-highlighting
    evalcache
)

# Path to the oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh

###############  Completions Loading Hack  #######

autoload -U +X bashcompinit && bashcompinit

###############  Completions  ####################

# [[ -f $HOME/.config/zsh/completions/openvpn3.zsh ]] &&
source $HOME/.config/zsh/completions/openvpn3.zsh

###############  Path Extensions  ################

# Binary paths
path+=('/usr/local/bin')
path+=("$HOME/.local/share/go/bin")
path+=("$HOME/.local/bin")
path+=("$HOME/.cargo/bin")
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

alias path="readlink -f"

# Backup to external drive, Github, and timeshift
function backup_full {
    sudo big_backup
    printf "\n"
    small_backup
}

function deactivate_conda_fully {
    for i in $(seq ${CONDA_SHLVL}); do
        conda deactivate
    done
}

# This evaluates to `pacman ...` or `sudo pacman ...` if needed
function pm {
    deactivate_conda_fully
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
    deactivate_conda_fully
    # sudo pacman -Sy --noconfirm && sudo powerpill -Su --noconfirm && paru -Su --noconfirm
    sudo pacman -Syu --noconfirm
    paru -Syu --noconfirm
    updatei3barchupdate
}

# Rebuild grub
alias grubmk="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias npmi="npm i --prefix $HOME/.local/share/npm"

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

function sc {
    pass -c ssh/private_password
    ssh gaetzner@cluster.ml.tu-berlin.de
}

function sk {
    ssh -X gaetzner@172.16.33.85 -L 8125:127.0.0.1:8125 -L 6006:127.0.0.1:6006
}

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

# Persistent live status changes of systemctl status
alias systemctl_persistent="journalctl --follow -u"

function svg2pdf {
    inkscape $1 --export-type=pdf
}

###############  Bluetooth  ######################

alias blue="bluetoothctl connect"
alias blued="bluetoothctl disconnect"

function bluer {
    sudo systemctl restart bluetooth
    blue $(history | grep '  blue [29CE]' | tail -1 | sed 's/.*  blue //')
    configure_keyboard
}

function speakc {
    blue C0:28:8D:05:C4:B5 1> /dev/null 2> /dev/null &
}

function speakd {
    blue C0:28:8D:05:C4:B5 1> /dev/null 2> /dev/null &
}

###############  Containerization  ###############

source <(kubectl completion zsh)

alias dbl="sudo docker build"
alias drn="sudo docker run -d --rm --gpus all"
alias dxe="sudo docker exec -it"
alias dps="sudo docker ps"
alias dkl="sudo docker kill"
alias dls="sudo docker images"
alias dpr="sudo docker container prune"

###############  VirtualBox  #####################

function reinstall_virtualbox {
    sudo pacman -R virtualbox virtualbox-host-dkms virtualbox-ext-oracle
    sudo pacman -S linux-lts-headers linux-headers
    sudo pacman -S virtualbox virtualbox-host-dkms virtualbox-ext-oracle
    sudo modprobe vboxdrv
}

###############  Beauty  #########################

function san {
    rename -S "ä" "ae" -S "ü" "ue" -S "ö" "oe" -S "Ä" "ae" -S "Ü" "ue" -S "Ö" "oe" **/*

    # Traverse through files and directories recursively, skipping hidden files and directories
    find . -depth -mindepth 1 -name '*' | while read -r file; do
        # Extract directory path
        dir=$(dirname "$file")

        # Skip if directory is hidden
        if [[ "$dir" =~ (^|/)\\..+(/|$) ]]; then
            continue
        fi

        # Extract filename
        filename=$(basename "$file")

        # Skip if file is hidden
        if [[ "$filename" == .* ]]; then
            continue
        fi

        # Convert filename to lowercase and replace underscores and spaces with hyphens
        new_filename=$(echo "$filename" | awk '{print tolower($0)}' | sed 's/_/-/g' | sed 's/ /-/g' | sed 's/^-//' | sed 's/-$//')

        # Generate new full path
        newfile="$dir/$new_filename"

        # If the filename changed, rename the file
        if [ "$file" != "$newfile" ]; then
            mv "$file" "$newfile"
        fi
    done
}

alias rsyncp="rsync -ah --info=progress2 --no-i-r"
alias rclones="rclone --progress --multi-thread-streams=50 sync --order-by size,asc"

alias cat='bat --style header --style snip --style changes --style header'

alias ls='exa -l --color=always --group-directories-first --icons' # preferred listing
alias la='exa -la --color=always --group-directories-first --icons'  # all files and dirs
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"

alias du='dust'
alias df='duf'

alias m="batman"

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

# Open files easily
function o {
    nohup mimeopen -n $@ >/dev/null 2>/dev/null &
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

alias i="/home/matteo/.mambaforge/envs/ml/bin/ipython3 --no-confirm-exit"

alias v=nvim

alias pc="pass -c"
alias poc="pass otp -c"

alias vime="nvim $HOME/.config/nvim/init.lua"
alias vimek="nvim $HOME/.config/nvim/lua/keymaps.lua"
alias vimed="nvim $HOME/.config/nvim/"
alias vimep="nvim $HOME/.config/nvim/lua/plugins.lua"
alias vimec="nvim $HOME/.config/nvim/coc-settings.json"

alias vifme="nvim $HOME/.config/vifm/vifmrc"

alias zshe="nvim $HOME/.zshrc; exec zsh"

alias sshe="nvim $HOME/.ssh/config"

alias i3e="nvim $HOME/.config/i3/config"
alias i3be="nvim $HOME/.config/i3blocks/config"

alias kittye="nvim $HOME/.config/kitty/kitty.conf; killall -s SIGUSR1 kitty"

alias xinite="sudo nvim $HOME/.xinitrc"

alias backupe="nvim $HOME/Sync/System/Backup/small_backup.sh"

function syshealth() {
  # get a list of all nvme devices (not partitions)
  dev_paths=("/dev/nvme0" "/dev/nvme1")
  echo "SSD Percent Used:"
  for dev_path in $dev_paths; do
    # get device usage percentage
    usage=$(sudo nvme smart-log $dev_path | grep "percentage_used" | awk '{print $3}')
    echo "  $dev_path: $usage"
  done
}

alias mutt="neomutt "
alias mutte="nvim $HOME/.config/mutt/muttrc"

alias vt="nvim *.tex"
alias vtt="nvim *.tex -c ':LLPStartPreview'"

alias vp="nvim *.py"

alias tma="tmux attach -t"
alias tms="tmux new -s"
alias tml="tmux ls"

alias gu="git add -u; git commit -m \"$@\"; git push"
alias gul="git add -u; git commit-status; git push"
alias gcos="git commit-status"

function compress_progress {
    # tar --use-compress-program="pigz -k " -cf - $1 -P | pv -s $(/usr/bin/du -sb $1 | awk '{print $1}') | gzip > $2.tar.gz
    tar cf - $1 -P | pv -s $(/usr/bin/du -sb $1 | awk '{print $1}') | gzip > $2.tar.gz
}

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

    if [ $# -eq 1 ]; then
        filename=$DATE_$1.md
        header="# $1"
    else
        filename=$DATE.md
        header="# $DATE"
    fi

    echo "$header" > "$filename"

    nvim "$filename"
}

###############  University  #####################

function latex_setup {
    mkdir build
    touch refs.bib
    latex_templates_path=$HOME/Dropbox/personal/programming/latex-templates/
    ln $latex_templates_path/packages/general.sty general.sty
    cp $latex_templates_path/packages/specific.sty specific.sty
    cp $latex_templates_path/templates/generic/main.tex main.tex
    cp $latex_templates_path/templates/generic/.gitignore .gitignore

    # Git
    git init --initial-branch=main
    git add refs.bib general.sty specific.sty main.tex .gitignore
    git commit -m "initial commit"
}

# pdflatex engine:
COMMON_LATEXMK_FLAGS_PDFLATEX=(--shell-escape -pdf -pdflatex='pdflatex -synctex=1 -interaction=nonstopmode -file-line-error' -output-directory=build/)
# lualatex engine:
COMMON_LATEXMK_FLAGS=(--shell-escape -pdf -pdflatex=lualatex -output-directory=build/)

# latex compile
function lco {
    latexmk "${COMMON_LATEXMK_FLAGS[@]}" $@
}

# latex clean compile (lualatex)
function lcc {
    latexmk "${COMMON_LATEXMK_FLAGS[@]}" -gg $@
}

# latex clean compile (pdflatex)
function lcc_pdflatex {
    latexmk "${COMMON_LATEXMK_FLAGS_PDFLATEX[@]}" -gg $@
}

# latex compile all
function lca {
    parallel latexmk "${COMMON_LATEXMK_FLAGS[@]}" {} ::: **/*.tex
}

# latex clean compile all
function lcca {
    parallel latexmk "${COMMON_LATEXMK_FLAGS[@]}" -gg {} ::: **/*.tex
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

function vpnf {
  sudo openvpn --config /home/matteo/Sync/Work/fraunhofer/vpn/HHIvpn48.ovpn --ca /home/matteo/Sync/Work/fraunhofer/vpn/HHIvpnCA48.pem
}

function vpnfd {
  sudo pkill openvpn
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


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/matteo/.mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/matteo/.mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/matteo/.mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/matteo/.mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/matteo/.mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/matteo/.mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# Ask for update after startup
if ! [[ -f "$ZSHUPDATEDFILE" ]]; then
    BOOTTIME=$(who -b | sed 's/.*\(..:..\)$/\1/' | sed 's/://')
    NOWTIME=$(date +%H%M)
    let "PREVMIN = $NOWTIME - 1"
    if ! [[ ($BOOTTIME = $NOWTIME) && ($BOOTTIME = $PREVMIN) ]]; then
        (sleep 10 && touch $ZSHUPDATEDFILE) &
        read -q "?Wanna copy gpg password in buffer? "
        if [[ $REPLY =~ [Yy] ]]; then
            pass -c master-password
        fi
        echo -e "\033[2K"
    fi
fi

mamba activate ml
_evalcache direnv hook zsh
_evalcache zoxide init zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
