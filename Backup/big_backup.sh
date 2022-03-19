#!/bin/bash

## my own rsync-based snapshot-style backup procedure
## (cc) marcio rps AT gmail.com

log_notify "Execution of backup script started"

# config vars
SRC="/home/matteo/" #dont forget trailing slash!
SNAP="/mnt/backup/matteo"
MAXN_SNAPS=20
OPTS="-rltgoi --delay-updates --delete --chmod=a-w"
_UUID=12f39b90-3fd5-4811-a2db-21d51e9ab864
MINCHANGES=100

# check whether this is run with sudo privileges
#if [ `id -u` -ne 0 ]; then
#  log_error "Missing sudo privileges to perform backup."
#  exit 1
#fi

# check whether external disk is connected
#if [ ! -L "/dev/disk/by-uuid/${_UUID}" ]; then
#  log_error "External drive with UUID: '${_UUID}' is not connected."
#  exit 1
#fi

# mount drive
if ! grep -qs '/mnt/backup $SNAP' /proc/mounts; then
  sudo mount UUID=$_UUID /mnt/backup
fi

# run this process with real low priority
ionice -c 3 -p $$ >/dev/null
renice +12  -p $$ >/dev/null

# delete oldest snapshot if there are at least MAXN_SNAPS present
let "nsnaps = $(/bin/ls -l $SNAP | grep -c ^d) - 1"
if [ $nsnaps -ge $MAXN_SNAPS ]; then
  oldest=$(/bin/ls -d --sort=time -r $SNAP/*/ | head -1)
  log_notify "Deleting oldest snapshot: $oldest"
  rm -rf $oldest
fi

# sync
log_notify "Starting to syncing data with rsync"
rsync $OPTS $SRC $SNAP/latest >> $SNAP/rsync.log

# check if enough has changed and if so
# make a hardlinked copy named as the date
COUNT=$( wc -l $SNAP/rsync.log|cut -d" " -f1 )
if [ $COUNT -gt $MINCHANGES ] ; then
  DATETAG=$(date +%Y-%m-%d)
  if [ ! -e $SNAP/$DATETAG ] ; then
    log_notify "Creating new snapshot: $DATETAG"
    cp -al $SNAP/latest $SNAP/$DATETAG
    chmod u+w $SNAP/$DATETAG
    mv $SNAP/rsync.log $SNAP/$DATETAG
    chmod u-w $SNAP/$DATETAG
  fi
fi

# cleanup
log_notify "Unmounting drive"
sudo umount /mnt/backup
