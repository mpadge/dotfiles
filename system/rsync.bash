#!/usr/bin/bash

UNAME=smexus
DEV=$(ls /run/media/$UNAME)

echo "---------------------------------------------------"
echo "1. Backup FROM /home TO $DEV"
echo "2. Backup FROM /data TO $DEV (excluding mega, Dropbox)"
echo "3. Backup FROM /data/mega TO $DEV"
echo "4. Backup FROM /data/Dropbox TO $DEV"
echo "5. Backup FROM $DEV TO /home"
echo "6. Backup FROM $DEV TO /data (excluding mega, Dropbox)"
echo "7. Backup FROM $DEV TO /data/mega"
echo "8. Backup FROM $DEV TO /data/Dropbox"
echo "---------------------------------------------------"

read -p "Enter option: " OPT
if [ "$OPT" == 1 ]; then
    read -p "Backup FROM /home TO $DEV right (y/n)? " DOIT
elif [ "$OPT" == 2 ]; then
    read -p "Backup FROM /data TO $DEV (exluding mega, Dropbox) right (y/n)? " DOIT
elif [ "$OPT" == 3 ]; then
    read -p "Backup FROM /data/mega TO $DEV right (y/n)? " DOIT
elif [ "$OPT" == 4 ]; then
    read -p "Backup FROM /data/Dropbox TO $DEV right (y/n)? " DOIT
elif [ "$OPT" == 5 ]; then
    read -p "Backup FROM $DEV TO /home right (y/n)? " DOIT
elif [ "$OPT" == 6 ]; then
    read -p "Backup FROM $DEV TO /data (exluding mega, Dropbox) right (y/n)? " DOIT
elif [ "$OPT" == 7 ]; then
    read -p "Backup FROM $DEV TO /data/mega right (y/n)? " DOIT
elif [ "$OPT" == 8 ]; then
    read -p "Backup FROM $DEV TO /data/Dropbox right (y/n)? " DOIT
else
    echo "Unknown option"
    exit 1
fi

DEV="/run/media/$UNAME/"$(ls /run/media/$UNAME)

#if ([ "$DOIT" != "y" ] || [ "$DOIT" != "Y" ]); then
if [ "$DOIT" != "y" ]; then
    exit 0
fi

read -p "Dry run ('NO' if not)? " DR
# flags are:
# -n : dry run
# -i : itemize changes
# -r : recurse into directories
# -l : copy symlinks as symlinks
# -t : preserve modification times
# -g : preserve group
# -o : preserve owner
# -D : preserve both device and special files
# -v : verbose
# -u : only update newer versions
# ... or -a = "-rlptgoD", where p = preserve permissions
#FLAGS="-nirltgoDv"
FLAGS="-nirtgoDv"
if [ "$DR" == "NO" ]; then
    echo "This is NOT a dry run - data will be changed"
    #FLAGS="-irv"
    FLAGS="-irltgoDvu" # -u to only update newer versions
fi

# modify-window matches timestamps only within 1s - critical for FAT32 partions;
# see https://linux.die.net/man/1/rsync
RSOPTS="--chmod=Du+rwx --progress --delete --ignore-errors --include '.*' --modify-window=1"

# sudo needed in all these to copy .git files to FAT32 systems
if [ "$OPT" == 1 ]; then
    DEST=$DEV/home/
    sudo rsync $FLAGS $RSOPTS --exclude $UNAME/.thunderbird \
        --exclude $UNAME/.mozilla/ --exclude $UNAME/.cache -s /home/ $DEST
elif [ "$OPT" == 2 ]; then
    DEST=$DEV/data/
    sudo rsync $FLAGS $RSOPTS --exclude "/Dropbox/" \
        --exclude "/mega/" -s /data/ $DEST
elif [ "$OPT" == 3 ]; then
    DEST=$DEV/data/mega/
    sudo rsync $FLAGS $RSOPTS -s /data/mega/ $DEST
elif [ "$OPT" == 4 ]; then
    DEST=$DEV/data/Dropbox/
    sudo rsync $FLAGS $RSOPTS -s /data/Dropbox/ $DEST
elif [ "$OPT" == 5 ]; then
    SRC=$DEV/home/
    sudo rsync $FLAGS $RSOPTS --exclude $UNAME/.thunderbird \
        --exclude $UNAME/.mozilla/ --exclude $UNAME/.cache -s $SRC /home/
elif [ "$OPT" == 6 ]; then
    SRC=$DEV/data/
    sudo rsync $FLAGS $RSOPTS --exclude "/Dropbox/" \
        --exclude "/mega/" -s $SRC /data/
elif [ "$OPT" == 7 ]; then
    SRC=$DEV/data/mega/
    sudo rsync $FLAGS $RSOPTS -s $SRC /data/mega/
elif [ "$OPT" == 8 ]; then
    SRC=$DEV/data/Dropbox/
    sudo rsync $FLAGS $RSOPTS -s $SRC /data/Dropbox/
fi
