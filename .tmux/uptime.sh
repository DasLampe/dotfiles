#!/usr/bin/env bash

up=$(cut -d ' ' -f1 < /proc/uptime)
up=${up%.*}

days=$(( up / 86400 ))
hours=$(( ( up % 86400 ) / 3600 ))
min=$(( (( up % 86400 ) % 3600 ) / 60 ))
sec=$(( (( up % 86400 ) % 3600 ) % 60 ))

[ $days = 0 ] || dout="${days}d "
[ $hours = 0 ] || hout="${hours}h "
[ $min = 0 ] || mout="${min}m "
[ $sec = 0 ] || sout="${sec}s"

echo "$dout$hout$mout$sout"