#!/bin/sh

# Sorted Disk Usage
sdu () {
	if [ $# -eq 0 ]
	then
		du -xhd 1 . | sort -h;
	else
		du -xhd 1 "$@" | sort -h;
	fi
}

alias rdf="df -h /" # Root filesystem disk usage

adf () {
	df -h | sed -n '1p; /^\/d/p'
}
