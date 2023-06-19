#!/bin/sh

watch -n 0.1 'cat /proc/cpuinfo | grep MHz && echo && lscpu | grep MHz'
