#!/bin/sh

if [ "$1" = start ]; then

    PATH=/usr/bin:/usr/sbin:/bin:/sbin

    mount -n -t tmpfs -o mode=775 tmpfs /run
    
    # nothing else is needed, initial ram fs has set up early filesystems
    # already

    # Must have sysfs mounted for udevtrigger to function.
    #mount -n -t sysfs sysfs /sys
    # Ideally devtmpfs will be mounted by kernel:
    #mount -n -t devtmpfs tmpfs /dev
    # "hidepid=1" doesn't appear to take effect on first mount of /proc,
    # so we mount it and then remount:
    #mount -n -t proc -o hidepid=1 proc /proc
    #mount -n -t proc -o remount,hidepid=1 proc /proc
    #mkdir /run/udev
    #mkdir /dev/pts
    #mkdir /dev/shm

fi
