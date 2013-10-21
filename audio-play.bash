#!/bin/bash
#
# Script bound to the play/pause button on a Logitexh S510
# Configured with the XF86AudioPlay keysym in ~/.i3/config
#

mpcstatus=$(mpc | awk 'NR==2 {print $1}')

if [ $mpcstatus = '[playing]' ]; then
    mpc -q pause
else
    mpc -q play
fi
