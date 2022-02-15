#! /bin/sh

DIRSIZE_LIMIT=25000

pnotify "Backing up to GitHub ..."

# installed packages
pacman -Q | awk '{print $1}' > ~/Sync/System/Pacman/packages_full.txt
pacman -Qe | awk '{print $1}' > ~/Sync/System/Pacman/packages_explicit.txt
pacman -Qet | awk '{print $1}' > ~/Sync/System/Pacman/packages_least.txt

# keyboard (http://anti.teamidiot.de/mrtweek/2006/10/deutsche_umlaute_auf_tastatur_mit_us-layout/)
rsync -av ~/.Xmodmap ~/Sync/System/Keyboard/.Xmodmap
rsync -av /etc/X11/xorg.conf.d/00-keyboard.conf ~/Sync/System/Keyboard/00-keyboard.conf

# zsh
rsync -av ~/.zprofile ~/Sync/System/Zsh/
rsync -av ~/.zshrc ~/Sync/System/Zsh/

# ssh
# gpg -e --recipient "Matteo Gaetzner" --output ~/Sync/System/Ssh/id_rsa.gpg --yes ~/.ssh/id_rsa
# rsync -av ~/.ssh/id_rsa.pub ~/Sync/System/Ssh/

# Neovim
rsync -av \
  --exclude={after,autoload,spell,UltiSnips} \
  ~/.config/nvim/ ~/Sync/System/Neovim/

# X
rsync -av ~/.xinitrc ~/Sync/System/X/.xinitrc
rsync -av ~/.Xresources ~/Sync/System/X/.Xresources

# i3blocks
rsync -av ~/.config/i3blocks/config ~/Sync/System/i3blocks/config

# i3
rsync -av ~/.config/i3/ ~/Sync/System/i3/

# vifm
rsync -av ~/.config/vifm/vifmrc ~/Sync/System/vifm/vifmrc
rsync -av ~/.config/vifm/scripts/ ~/Sync/System/vifm/scripts/

# kitty
rsync -av ~/.config/kitty/ ~/Sync/System/kitty/

# samba
rsync -av /etc/samba/smb.conf ~/Sync/System/Samba/smb.conf

# services (don't forget to chmod a+x resume and enable the services)
rsync -av /usr/lib/systemd/system/reflector.timer ~/Sync/System/Services/reflector.timer
rsync -av /etc/systemd/system/resume@.service ~/Sync/System/Services/resume@.service
rsync -av ~/.local/bin/resume ~/Sync/System/Services/resume

# print scripts
rsync -av ~/.local/bin/pnotify ~/Sync/System/Print.Scripts/pnotify
rsync -av ~/.local/bin/pwarn ~/Sync/System/Print.Scripts/pwarn
rsync -av ~/.local/bin/perror ~/Sync/System/Print.Scripts/perror
rsync -av ~/.local/bin/psuccess ~/Sync/System/Print.Scripts/psuccess

# i3 layout
rsync -av ~/.i3 ~/Sync/System/i3

# git
rsync -av ~/.gitignore ~/Sync/System/Git/.gitignore
rsync -av ~/.gitconfig ~/Sync/System/Git/.gitconfig

# login message
rsync -av /etc/issue ~/Sync/System/Login/issue

# ipython profile (setup: ipython profile create default, then replace in ~/.ipython...)
rsync -av ~/.ipython/profile_default/ipython_config.py ~/Sync/System/ipython/ipython_config.py

# flashfocus, picom
rsync -av ~/.config/picom/picom.conf ~/Sync/System/Picom/picom.conf

# cpupower frequency scaling
rsync -av /etc/default/cpupower ~/Sync/System/cpupower/cpupower


dirsize=$(du ~/Sync/System | tail -n 1 | sed 's/\t.*//')

if [[ $dirsize -ge $DIRSIZE_LIMIT ]]; then
  perror "You probably tried to backup some very large files. Check if you really want to commit $dirsize bytes."
else
  git -C ~/Sync/System pull
  git -C ~/Sync/System add .
  git -C ~/Sync/System commit-status
  git -C ~/Sync/System push
fi

psuccess "Backup to GitHub done."
