#!/bin/sh

cat ~/.bash_history | awk '{print $1 != "sudo" ? $1 : $2}' \
                    | awk 'BEGIN {FS="|"} {print $1}' \
                    | sort \
                    | uniq -c \
                    | sort -rn \
                    | less
