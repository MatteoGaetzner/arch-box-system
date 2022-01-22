#!/bin/bash

## my own rsync-based snapshot-style backup procedure
## (cc) marcio rps AT gmail.com

# config vars

SRC="/home/matteo/Sync/" #dont forget trailing slash!
SNAP="/mnt/backup/matteo"
OPTS="-rltgoi --delay-updates --delete --chmod=a-w"
_UUID=12f39b90-3fd5-4811-a2db-21d51e9ab864
MINCHANGES=20

# check whether this is run with sudo privileges
if [ `id -u` -ne 0 ]; then
  perror "Missing sudo privileges to perform backup."
  exit 1
fi

# check whether external disk is connected
if [ ! -L "/dev/disk/by-uuid/${_UUID}" ]; then
  perror "External drive with UUID: '${_UUID}' is not connected."
  exit 1
fi

pnotify "Backing up to external drive ..."

# mount drive
if ! grep -qs '/mnt/backup ' /proc/mounts; then
  sudo mount UUID=$_UUID /mnt/backup
fi

# run this process with real low priority

ionice -c 3 -p $$ >/dev/null
renice +12  -p $$ >/dev/null

# sync

rsync $OPTS $SRC $SNAP/latest >> $SNAP/rsync.log >/dev/null 2>/dev/null

# check if enough has changed and if so
# make a hardlinked copy named as the date

COUNT=$( wc -l $SNAP/rsync.log|cut -d" " -f1 )
if [ $COUNT -gt $MINCHANGES ] ; then
  DATETAG=$(date +%Y-%m-%d)
  if [ ! -e $SNAP/$DATETAG ] ; then
    cp -al $SNAP/latest $SNAP/$DATETAG
    chmod u+w $SNAP/$DATETAG
    mv $SNAP/rsync.log $SNAP/$DATETAG
    chmod u-w $SNAP/$DATETAG
  fi
fi

# cleanup
sudo umount /mnt/backup