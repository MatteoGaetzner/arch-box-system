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

# Ugly, but pyenv needs to be loaded before loading the corresponding OMZ plugin
eval "$(pyenv init --path)"

# Plugins
plugins=(
  pass
  pip
  pyenv
  emoji
  dotenv
  pip
  pyenv
  git
  git-extras
  archlinux
  zsh-autosuggestions
  zsh-vi-mode
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

# Optional
path+=("$HOME/.local/share/bsprak.toolchain/arm/bin")

export PATH

XDG_DATA_HOME=$HOME/.local/share

# Dynamic library path i.e. where the OS finds *.so files
LD_LIBRARY_PATH=/usr/lib
export LD_LIBRARY_PATH

# Go Programs
GOPATH="$HOME/.local/share/go"
export GOPATH

###############  System Utils  ###################

alias sudo='doas'
alias sudoedit='doas rnano'

# Backup to Github, and timeshift
function backup_fast {
  pnotify "Starting timeshift snapshot creation ..."
  sudo timeshift --create
  psuccess "Timeshift snapshot creation done.\n"
  small_backup
}

# Backup to external drive, Github, and timeshift
function backup_full {
  doas big_backup
  printf "\n"
  backup_fast
}

# This evaluates to `pacman ...` or `sudo pacman ...` if needed
function pm {
  case $1 in
    -S | -D | -S[^sih]* | -R* | -U*)
      sudo pacman "$@" ;;
    *)
      pacman "$@" ;;
  esac
}

alias pmb="backup_full; printf '\n';  pm $@"

# Shutdown/Reboot + backup
alias sdown="backup_full; shutdown now"
alias rboot="backup_full; systemctl reboot"

function update {
  pmb -Syu
  pnotify "Starting to upgrade user repository packages ..."
  yay --noconfirm -Syu
  psuccess "Upgrade of user repository packages done.\n"
}

alias npmi="npm i --prefix $HOME/.local/share/npm"

function mine {
  sudo xmrig --cuda --donate-level 0 -o de.haven.herominers.com:1110 -u $(pass havenprotocol.org/address) -p my_xmrig_worker -a cn-heavy/xhv -k
}

alias sc="kitty +kitten ssh cluster"

###############  Bluetooth  ######################

alias blue="bluetoothctl connect"
alias blued="bluetoothctl disconnect"

###############  Beauty  #########################

alias rsyncp="rsync -ah --info=progress2 --no-i-r"

alias cat='bat --style header --style rules --style snip --style changes --style header'

alias ls='exa -l --color=always --group-directories-first --icons' # preferred listing
alias la='exa -la --color=always --group-directories-first --icons'  # all files and dirs
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

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

# Open files easily
function o {
  mimeopen -n $@ >/dev/null 2>/dev/null &
  disown
}

# Enable z.lua fast cd
eval "$(lua $HOME/.local/share/z.lua/z.lua --init zsh)"

# Copying and pasting from command line
alias c="xclip -sel c <"
alias v="xclip -sel c -o >"

# Run vifm with image and video preview support
alias vifm="$HOME/.local/bin/vifmrun"

# Fast tree
alias t="tree -C -a --dirsfirst"

# ls after cd
function cl {
  new_directory="$*";
  if [ $# -eq 0 ]; then
    new_directory=${HOME};
  fi;
  builtin cd "${new_directory}" && ls
}

# find things
function f {
  tmpstr="$@"
  sudo find / -name "$tmpstr" -exec ls --color -d {} \;
}

function fl {
  tmpstr="$@"
  find . -name "$tmpstr" -exec ls --color -d {} \;
}

function pg {
  tmpstr="$@"
  pdfgrep -r --cache --color auto --ignore-case --regexp="$tmpstr" .
}

# ipython
alias i="/home/matteo/.pyenv/versions/ml/bin/ipython --no-confirm-exit"
alias v="nvim"

alias vime="nvim $HOME/.config/nvim/init.vim"
alias vimed="nvim $HOME/.config/nvim/"
alias vimep="nvim $HOME/.config/nvim/vim-plug/plugins.vim"
alias vimec="nvim $HOME/.config/nvim/coc-settings.json"

alias vifme="nvim $HOME/.config/vifm/vifmrc"

alias zshe="nvim $HOME/.zshrc; zsh"

alias i3e="nvim $HOME/.config/i3/config"
alias i3be="nvim $HOME/.config/i3blocks/config"

alias kittye="nvim $HOME/.config/kitty/kitty.conf; killall -s SIGUSR1 kitty"

alias xinite="sudo nvim $HOME/.xinitrc"

alias backupe="nvim $HOME/Sync/System/Backup/small_backup.sh"

alias vt="nvim *.tex"

function smbe {
  sudo nvim /etc/samba/smb.conf
  sudo smbcontrol all reload-config
  sudo systemctl restart smb nmb
}

###############  University  #####################

function clean_course {
  echo "$1" | sed 's/\[//g; s/\]//g'
}

function u {
  WORK_DIR=/home/matteo/Sync/University
  ISISDL_DIR=/home/matteo/Isis/Courses
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
    [Cc]s* )
      COURSE='CognitiveAlgorithms' ;;
    [Cc]* )
      COURSE='SoSe21CognitiveAlgorithms' ;;
    [Dd]* )
      COURSE='DigitalImageProcessingWS2122' ;;
    [Ii]* )
      COURSE='WS21InformationGovernance' ;;
    [Bb]o* )
      COURSE='WS2021Betriebssystempraktikum' ;;
    [Bb]* )
      COURSE='WS2122Betriebssystempraktikum' ;;
    [Mm]o* )
      COURSE='WiSe2021MachineLearning1' ;;
    [Mm]* )
      COURSE='WiSe2122MachineLearning1' ;;
  esac

  COURSE_CLEAN=$(clean_course $COURSE)

  case $argc in
    1 )
      cl "$ISISDL_DIR/$COURSE/" ;;
    2 )
      case $subdir in
        s )
          cl "$WORK_DIR/$COURSE_CLEAN/Solutions/" ;;
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

function latexmk_preview {
  latexmk -outdir=out -pvc -pdf
}

function setup_latex {
  mkdir out images
  ln $HOME/Sync/Programs/Self/Latex/Packages/general.sty general.sty
  cp $HOME/Sync/Programs/Self/Latex/Packages/specific.sty specific.sty
  cp $HOME/Sync/Programs/Self/Latex/Templates/Generic/main.tex main.tex
}

function jl {
  jupyter-lab $1
}

function jn {
  jupyter notebook $1
}


###############  VPN  ############################

# Connect to the VPN of Technische Universität Berlin
# alias vpnt='openconnect https://vpn.tu-berlin.de/ -b'
function vpnt {
  pnotify "Connecting to the VPN of Technische Universität Berlin ..."
  vpnnd >/dev/null
  sudo openconnect https://vpn.tu-berlin.de/ -q -b -u matteo
  psuccess "Connection established."
}

# Disconnect from the VPN of Technische Universität Berlin
function vpntd {
  sudo pkill openconnect
  psuccess "Disconnected from the VPN of Technische Universität Berlin."
}

# Connect to the VPN of NordVPN
function vpnn {
  pnotify "Connecting to NordVPN ..."
  if [[ $(pidof openconnect >/dev/null && echo $?) == 0 ]]; then
    vpntd >/dev/null
  fi
  if [[ $(systemctl status nordvpnd) != *"active (running)"* ]]; then
    sudo systemctl enable nordvpnd
  fi
  if [[ $(nordvpn connect) == *"not logged in"* ]]; then
    nordvpn login
  fi
  nordvpn connect $@
}

# Disconnect from NordVPN
function vpnnd {
  nordvpn disconnect
  psuccess "Disconnected from NordVPN."
}

###############  Exports  ########################

# To enable importing gpg keys via qr codes
# See: https://wiki.archlinux.org/title/Paperkey
export EDITOR=nvim

# Make gpg work, check `man gpg-agent`
export GPG_TTY=$TTY

###############  R  ##############################

R_LIBS=$HOME/.local/share/R/lib/
export R_LIBS

###############  Python  #######################

alias activate="source *_env/bin/activate"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1

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

###############  Deep Learning  ##################

function csv_to_unix {
  tr -d '\15\32' < $1 > unix_$1
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

# Zsh syntax highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


