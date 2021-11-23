#!/bin/sh

	find /sys -name modalias -type f -print0 | xargs -0 sort -u \
		| xargs modprobe -b -a 2> /dev/null
	# we run it twice so we detect all devices
	find /sys -name modalias -type f -print0 | xargs -0 sort -u \
		| xargs modprobe -b -a 2> /dev/null

	# check if framebuffer drivers got pulled in
	if [ -e /dev/fb0 ] && ! [ -e /sys/module/fbcon ]; then
		modprobe -b -q fbcon
	fi
