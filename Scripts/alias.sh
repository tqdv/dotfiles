#!/bin/sh

# Sorted Disk Usage
sdu () {
	# -a --all
	# -D --dereference-args
	# -h --human-readable
	# -x --one-file-system
	# -d1 --max-depth=1
	if [ $# -eq 0 ]
	then du -aDhxd1 . | sort -h;
	else du -aDhxd1 "$@" | sort -h;
	fi
}

# Appends a slash if the 2nd tab-separated field is a directory
sd_aux () {
	perl -na -F'\t' -e 'chomp; print; chomp($p = $F[1]); if (-d $p && substr($p, -1) ne "/") {print "/"} print $/'
}

# Sorted Disk Usage with a '/' for directories
# NB: depends on perl
# This is similar to `ls -A1shFSr --color=never` except directories have sizes
sd () {
	sdu "$@" | sd_aux
}

# Root filesystem disk usage
alias rdf="df -h /"

# df of /dev/*
adf () {
	df -h | sed -n '1p; /^\/d/p'
}

alias ,=comma
