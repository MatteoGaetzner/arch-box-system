#! /bin/sh

RSYNCOPTS="-av"

DIRSIZE_LIMIT=25000

REPO_LOC="$HOME/Sync/System/"

log_info "Backing up to GitHub ..."

# installed packages
pacman -Q | awk '{print $1}' >~/Sync/System/Pacman/packages_full.txt
pacman -Qe | awk '{print $1}' >~/Sync/System/Pacman/packages_explicit.txt
pacman -Qet | awk '{print $1}' >~/Sync/System/Pacman/packages_least.txt

# keyboard (http://anti.teamidiot.de/mrtweek/2006/10/deutsche_umlaute_auf_tastatur_mit_us-layout/)
rsync $RSYNCOPTS ~/.Xmodmap ~/Sync/System/Keyboard/.Xmodmap
rsync $RSYNCOPTS /etc/X11/xorg.conf.d/00-keyboard.conf ~/Sync/System/Keyboard/00-keyboard.conf
rsync $RSYNCOPTS /etc/udev/rules.d/{81-bluetooth-disable-controller.rules,91-keyboardmousewakeup.rules,92-keyboardreconfigurationwakeup.rules} ~/Sync/System/Keyboard/

# watchdog timer
rsync $RSYNCOPTS /etc/modprobe.d/sp5100_tco.conf ~/Sync/System/Motherboard/sp5100_tco.conf

# pipewire
rsync $RSYNCOPTS /usr/share/pipewire/pipewire.conf ~/Sync/System/pipewire/pipewire.conf

# turn off bell sounds in terminal
rsync $RSYNCOPTS /etc/inputrc ~/Sync/System/Zsh/inputrc

# fstab
rsync $RSYNCOPTS /etc/fstab ~/Sync/System/Fstab/fstab

# pacman conf
rsync $RSYNCOPTS /etc/pacman.conf ~/Sync/System/Pacman/pacman.conf

# udev rules
rsync $RSYNCOPTS /etc/udev/rules.d/ ~/Sync/System/udev/rules.d/

# zsh
rsync $RSYNCOPTS ~/.zprofile ~/Sync/System/Zsh/.zprofile
rsync $RSYNCOPTS ~/.zshrc ~/Sync/System/Zsh/.zshrc
rsync $RSYNCOPTS ~/.config/zsh/completions/ ~/Sync/System/Zsh/completions/

# broot
rsync $RSYNCOPTS ~/.config/broot/conf.hjson ~/Sync/System/broot/conf.hjson

# tmux
rsync $RSYNCOPTS ~/.config/tmux/tmux.conf ~/Sync/System/Tmux/tmux.conf

# parallel
rsync $RSYNCOPTS ~/.parallel/config ~/Sync/System/Parallel/config

# mutt
rsync $RSYNCOPTS ~/.config/mutt/accounts/ ~/Sync/System/mutt/accounts/
rsync $RSYNCOPTS ~/.config/mutt/mailbox_reset.muttrc ~/Sync/System/mutt/mailbox_reset.muttrc
rsync $RSYNCOPTS ~/.config/mutt/muttrc ~/Sync/System/mutt/muttrc
rsync $RSYNCOPTS ~/.mbsyncrc ~/Sync/System/mutt/.mbsyncrc
rsync $RSYNCOPTS ~/.config/msmtp/config ~/Sync/System/mutt/msmtp/config

# crontabs
rsync $RSYNCOPTS /var/spool/cron/matteo ~/Sync/System/cron/matteo

# ssh
# gpg -e --recipient "Matteo Gaetzner" --output ~/Sync/System/Ssh/id_rsa.gpg --yes ~/.ssh/id_rsa
# rsync $RSYNCOPTS ~/.ssh/id_rsa.pub ~/Sync/System/Ssh/
rsync $RSYNCOPTS ~/.ssh/config ~/Sync/System/Ssh/config

# Fangfrisch (for clamav)
# gpg -e --recipient "Matteo Gaetzner" --output ~/Sync/System/Fangfrisch/fangfrisch.conf.gpg --yes /etc/fangfrisch/fangfrisch.conf

# Backup scripts
rsync $RSYNCOPTS /bin/spinner ~/Sync/System/Backup/spinner.sh
rsync $RSYNCOPTS /bin/big_backup ~/Sync/System/Backup/big_backup.sh

# Neovim
rsync $RSYNCOPTS \
	--exclude={after,autoload,spell} \
	~/.config/nvim/ ~/Sync/System/Neovim/

# X
rsync $RSYNCOPTS ~/.xinitrc ~/Sync/System/X/.xinitrc
rsync $RSYNCOPTS ~/.Xresources ~/Sync/System/X/.Xresources

# i3blocks
rsync $RSYNCOPTS ~/.config/i3blocks/config ~/Sync/System/i3blocks/config
rsync $RSYNCOPTS ~/.config/i3blocks/gpu-load/gpu-load ~/Sync/System/i3blocks/gpu-load/gpu-load
rsync $RSYNCOPTS ~/.config/i3blocks/arch-update/arch-update ~/Sync/System/i3blocks/arch-update/arch-update
rsync $RSYNCOPTS ~/.config/i3blocks/mymemory/mymemory ~/Sync/System/i3blocks/mymemory/mymemory
rsync $RSYNCOPTS ~/.config/i3blocks/mydisk/ ~/Sync/System/i3blocks/mydisk/
rsync $RSYNCOPTS ~/.config/i3blocks/backup/backup ~/Sync/System/i3blocks/backup/backup
rsync $RSYNCOPTS ~/.config/i3blocks/mail/mail ~/Sync/System/i3blocks/mail/mail

rsync $RSYNCOPTS ~/.config/i3blocks/ssd-health/ ~/Sync/System/i3blocks/ssd-health/
# i3
rsync $RSYNCOPTS ~/.config/i3/ ~/Sync/System/i3/

# vifm
rsync $RSYNCOPTS ~/.config/vifm/vifmrc ~/Sync/System/vifm/vifmrc
rsync $RSYNCOPTS ~/.config/vifm/scripts/ ~/Sync/System/vifm/scripts/

# kitty
rsync $RSYNCOPTS ~/.config/kitty/ ~/Sync/System/kitty/

# samba
rsync $RSYNCOPTS /etc/samba/smb.conf ~/Sync/System/Samba/smb.conf

# services (don't forget to chmod a+x resume and enable the services)
rsync $RSYNCOPTS /etc/systemd/system/big_backup.service ~/Sync/System/Services/big_backup.service
rsync $RSYNCOPTS /etc/systemd/system/big_backup.timer ~/Sync/System/Services/big_backup.timer
rsync $RSYNCOPTS /etc/systemd/system/btrfs_defrag.service ~/Sync/System/Services/btrfs_defrag.service
rsync $RSYNCOPTS /etc/systemd/system/btrfs_defrag.timer ~/Sync/System/Services/btrfs_defrag.timer
rsync $RSYNCOPTS /etc/systemd/system/resume@.service ~/Sync/System/Services/resume@.service
rsync $RSYNCOPTS /usr/lib/systemd/system/reflector.timer ~/Sync/System/Services/reflector.timer
rsync $RSYNCOPTS ~/.local/bin/configure_keyboard ~/Sync/System/Services/configure_keyboard

# print scripts
rsync $RSYNCOPTS /bin/log_info ~/Sync/System/Print.Scripts/log_info
rsync $RSYNCOPTS /bin/log_warn ~/Sync/System/Print.Scripts/log_warn
rsync $RSYNCOPTS /bin/log_error ~/Sync/System/Print.Scripts/log_error
rsync $RSYNCOPTS /bin/log_success ~/Sync/System/Print.Scripts/log_success

# i3 layout
rsync $RSYNCOPTS ~/.i3 ~/Sync/System/i3

# git
rsync $RSYNCOPTS ~/.gitignore ~/Sync/System/Git/.gitignore
rsync $RSYNCOPTS ~/.gitconfig ~/Sync/System/Git/.gitconfig

# login message
rsync $RSYNCOPTS /etc/issue ~/Sync/System/Login/issue

# ipython profile (setup: ipython profile create default, then replace in ~/.ipython...)
rsync $RSYNCOPTS ~/.ipython/profile_default/ipython_config.py ~/Sync/System/ipython/ipython_config.py

# pdb++
rsync $RSYNCOPTS ~/.pdbrc.py ~/Sync/System/Python/.pdbrc.py

# pylintrc
rsync $RSYNCOPTS ~/.pylintrc ~/Sync/System/Python/.pylintrc

# flashfocus, picom
rsync $RSYNCOPTS ~/.config/picom/picom.conf ~/Sync/System/Picom/picom.conf

# cpupower frequency scaling
rsync $RSYNCOPTS /etc/default/cpupower ~/Sync/System/cpupower/cpupower

# make
rsync $RSYNCOPTS /etc/makepkg.conf ~/Sync/System/Make/makepkg.conf

dirsize=$(du "$REPO_LOC" | tail -n 1 | sed 's/\t.*//')

if [ "$dirsize" -ge "$DIRSIZE_LIMIT" ]; then
	log_error "You probably tried to backup some very large files. Check if you really want to commit $dirsize bytes."
else
	git -C "$REPO_LOC" pull
	git -C "$REPO_LOC" add .
	git -C "$REPO_LOC" commit --all -m "update"
	git -C "$REPO_LOC" push
fi

log_success "Backup to GitHub done."
