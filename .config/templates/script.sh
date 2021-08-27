#!/bin/sh

err() {
	echo "ERROR: $*" 1>&2
}

die() {
	err "$*"
	exit 1
}

main() {
	die "TODO"
}

main "$@"
