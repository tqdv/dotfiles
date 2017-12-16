#!/bin/sh

# Sorted Disk Usage
# -a --all
# -D --dereference-args
# -h --human-readable
# -x --one-file-system
# -d1 --max-depth=1
sdu () {
	if [ $# -eq 0 ]
	then
		du -aDhxd1 . | sort -h;
	else
		du -aDhxd1 "$@" | sort -h;
	fi
}

alias rdf="df -h /" # Root filesystem disk usage

adf () {
	df -h | sed -n '1p; /^\/d/p'
}
