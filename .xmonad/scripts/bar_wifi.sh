#!/bin/bash

source $(dirname $0)/config.sh

QUAL=`iwconfig wlp5s0 | grep 'Link Quality=' | awk '{gsub(/[=/]/," "); print $3}'`
MAX=`iwconfig wlp5s0 | grep 'Link Quality=' | awk '{gsub(/[=/]/," "); print $4}'`
PERC=`echo $QUAL*100/$MAX | bc`

color="#636e74"

if [[ $PERC -lt 20 ]]; then
	ICON="wireless1.xbm"
	color="^fg($warning)"
elif [[ $PERC -lt 40 ]]; then
	ICON="wireless2.xbm"
	color="^fg($notify)"
elif [[ $PERC -lt 60 ]]; then
	ICON="wireless3.xbm"
elif [[ $PERC -lt 80 ]]; then
	ICON="wireless4.xbm"
elif [[ $PERC -lt 101 ]]; then
	ICON="wireless5.xbm"
fi

ICON='^i(/home/clement/.xmonad/dzen2/'"$ICON)"
echo "$color$ICON"