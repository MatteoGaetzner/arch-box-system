#!/bin/bash

## my own rsync-based snapshot-style backup procedure
## (cc) marcio rps AT gmail.com

log_info "Execution of backup script started"

# config vars
SRC="/home/matteo/" #dont forget trailing slash!
MOUNTPOINT="/mnt/backup/"
SNAP="/mnt/backup/matteo"
TMPLOGFILE="/tmp/rsynctmplog9713849571234978234879test.log"
i3INFO_FILE="$SRC/.config/i3blocks/backup/backup.space.info"
MAXN_SNAPS=70
OPTS="-rltgoi --delay-updates --delete --chmod=a-w"
_UUID=12f39b90-3fd5-4811-a2db-21d51e9ab864
SDANAME=$(lsblk --output NAME,UUID | grep '12f39b90-3fd5-4811-a2db-21d51e9ab864' | awk '{ print $1 }' | sed 's/.*\(sda.*\)/\1/')
MINCHANGES=100

function bytesToHuman {
    numfmt --to iec --format "%.1f" "$1"
}

function getBytesOnDisk {
    BLOCKSONDISK=$(/usr/bin/df "/dev/$SDANAME" | tail -1 | awk '{print $4}')
    local SPACEONDISK_BYTES=$((BLOCKSONDISK * 1000))
    echo "$SPACEONDISK_BYTES"
}

function removeOldest {
    oldest=$(/bin/ls -d --sort=time -r $SNAP/*/ | head -1)
    log_info "Deleting oldest snapshot: $oldest"
    rm -rf "$oldest"
}

function makeSpace {
    local TRANSFER_SIZE=$1
    local SPACE_ON_DISK
    SPACE_ON_DISK=$(getBytesOnDisk)
    log_info "Removing enough backups to save $TRANSFER_SIZE additional bytes."

    # Sanity check whether correct input (greater than zero) was given
    if ! [[ $1 -gt 0 ]]; then
        log_error "Sanity check failed: Called makeSpace() with a transfer size of $1 bytes!"
        exit 1
    fi

    while [[ $SPACE_ON_DISK -lt $TRANSFER_SIZE ]]; do

        # Sanity check: Leave at least 4 snapshots
        local NSNAPS=$(($(/bin/ls -l $SNAP | grep -c ^d) - 1))
        if [[ $NSNAPS -lt 5 ]]; then
            log_error "Sanity check failed: Only $NSNAPS left!"
            exit 1
        fi

        removeOldest
        SPACE_ON_DISK=$(getBytesOnDisk)
        log_info "There are $(bytesToHuman "$SPACE_ON_DISK") left on the the device."
    done
}

# mount drive
if grep -qs "$MOUNTPOINT " /proc/mounts; then
    log_info "Backup device with UUID $_UUID is already mounted at $MOUNTPOINT."
else
    sudo mount UUID=$_UUID "$MOUNTPOINT"
fi

# run this process with real low priority
ionice -c 3 -p $$ >/dev/null
renice +12 -p $$ >/dev/null

# delete oldest snapshot if there are at least MAXN_SNAPS present
nsnaps=$(($(/bin/ls -l $SNAP | grep -c ^d) - 1))
if [ $nsnaps -ge $MAXN_SNAPS ]; then
    oldest=$(/bin/ls -d --sort=time -r $SNAP/*/ | head -1)
    log_info "Deleting oldest snapshot: $oldest"
    rm -rf "$oldest"
fi

# Check whether there is enough space on the disk
log_info "Starting dry run"
rsync --dry-run --stats $OPTS "$SRC" "$SNAP/latest" >"$TMPLOGFILE"

TRANSFERRED_BYTES=$(grep "Total transferred file size: " $TMPLOGFILE | sed 's/,//g' | sed 's/.*: \([0-9]*\).*$/\1/')

log_info "Finished dry run"

SPACEONDISK_BYTES=$(getBytesOnDisk)

# Get human readable space
TRANSFERRED_F=$(numfmt --to iec --format "%.1f" "$TRANSFERRED_BYTES")
SPACEONDISK_F=$(/usr/bin/df -h /dev/"$SDANAME" | tail -1 | awk '{print $4}')

if [[ $SPACEONDISK_BYTES -lt $TRANSFERRED_BYTES ]]; then
    log_warn "External drive doesn't have enough available space, $SPACEONDISK_F, to store $TRANSFERRED_F."
    makeSpace "$TRANSFERRED_BYTES"
else
    log_info "External drive still has enough available space, $SPACEONDISK_F, to store approximately $TRANSFERRED_F."
fi

# Save space on disk to
if [ -f "$i3INFO_FILE" ]; then
    /usr/bin/df /dev/sda1 | tail -1 >"$SRC/.config/i3blocks/backup/backup.space.info"
fi

# sync
log_info "Starting to transfer data with rsync"
rsync $OPTS "$SRC" "$SNAP/latest" >>"$SNAP/rsync.log"

# check if enough has changed and if so
# make a hardlinked copy named as the date
COUNT=$(wc -l "$SNAP/rsync.log" | cut -d" " -f1)
if [ "$COUNT" -gt "$MINCHANGES" ]; then
    DATETAG=$(date +%Y-%m-%d)
    if [ ! -e "$SNAP/$DATETAG" ]; then
        log_info "Creating new snapshot: $DATETAG"
        cp -al "$SNAP/latest" "$SNAP/$DATETAG"
        chmod u+w "$SNAP/$DATETAG"
        mv "$SNAP/rsync.log" "$SNAP/$DATETAG"
        chmod u-w "$SNAP/$DATETAG"
    fi
fi

# cleanup
log_info "Unmounting drive"
sudo umount $MOUNTPOINT
