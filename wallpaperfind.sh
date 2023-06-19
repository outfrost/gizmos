#!/bin/sh

# This script checks files passed as parameters and outputs a list of those
# of them which satisfy the user-provided (or default) requirements for being
# suitable for use as a desktop wallpaper.

if [ $# -lt 3 ]; then
	echo "Usage: $(basename $0) <min_width> <min_height> <files...>" >&2
	exit 1
fi

minWidth="$1"
minHeight="$2"
shift 2

for f in "$@"; do
	read width height <<- END_OF_PIPE
		$(identify -format "%w %h\n" "$f")
	END_OF_PIPE
	
	if [ "$width" -ge "$minWidth" -a "$height" -ge "$minHeight" ]; then
		echo "$f"
	fi
done 2> /dev/null
