#!/bin/sh

interval="$1"
shift

while true
do
	cmdoutput="$(2>&1 $@)"
	if [ "$cmdoutput" != "$oldcmdoutput" ]
	then
		oldcmdoutput="$cmdoutput"
		printf "\n\n\n\n%s" "$cmdoutput"
	fi
	sleep "$interval"
done
