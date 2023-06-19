#!/bin/bash

clear && tput civis \
      && watch -n 1 -pt "echo '\n\n\n\n' && date +'   %a %d %b' | toilet -w 160 -f bigascii12 && date +'    %H:%M:%S' | toilet -w 160 -f bigascii12"

tput cnorm
