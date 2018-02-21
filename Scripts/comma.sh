#!/bin/bash

comma() {
	case $1 in
	'cr') cat /etc/resolv.conf;;
	'ck') curl kawa.ga;;
	*) ;;
	esac
}
