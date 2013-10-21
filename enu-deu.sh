#!/bin/bash
#
#   A script to change the keyboard layout between
#   English and German.
#   Bound to the XF86HomePage keysym in ~/.i3/config

xkbstatus=$(setxkbmap -query | awk 'NR==3 {print $2}')

if [ $xkbstatus  = 'us' ]; then
    setxkbmap de
elif [ $xkbstatus  = 'de' ]; then
    setxkbmap us
fi
