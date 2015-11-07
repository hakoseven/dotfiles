#!/bin/bash
source $(dirname $0)/config.sh
XPOS=$((1180 + $XOFFSET))
WIDTH="180"
LINES="9"

playing=$(cmus-remote -Q | grep title | cut -d " " -f 3-)
artist=$(cmus-remote -Q | grep -m 1 artist | cut -d " " -f 3-)
album=$(cmus-remote -Q | grep -m 1 album | cut -d " " -f 3-)
track=$(cmus-remote -Q | grep title | cut -d " " -f 3-)
date=$(cmus-remote -Q | grep date | cut -d " " -f 3-)
#stats=$(mpc stats)
#playlistcurrent=$(mpc playlist | grep -n "$playing" | cut -d ":" -f 1 | head -n1)
#nextnum=$(( $playlistcurrent + 1 ))
#prevnum=$(( $playlistcurrent - 1 ))
#next=$(mpc playlist | sed -n ""$nextnum"p")
#prev=$(mpc playlist | sed -n ""$prevnum"p")
#art=$(ls ~/.config/ario/covers | grep SMALL | grep $album)
art="/home/clement/.config/ario/covers/$(ls ~/.config/ario/covers | grep -v SMALL | grep "$(mpc current -f %album% | sed 's/:/ /g')")"
perc=`mpc | awk 'NR == 2 {gsub(/[()%]/,""); print $4}'`
 
percbar=`echo -e "$perc" | gdbar -bg $bar_bg -fg $foreground -h 1 -w $(($WIDTH-20))`

#84x84
feh -x -B black -^ "" -g 108x108+$(($XPOS-108))+$(($YPOS+12)) -Z "$art" &
(echo "^fg($highlight)Music"; echo "       ";echo "^ca(1,/home/clement/.xmonad/scripts/dzen_lyrics.sh)  Track:  ^fg($highlight)$track^ca()"; echo "^ca(1,/home/clement/.xmonad/scripts/dzen_artistinfo.sh)^fg()  Artist: ^fg($highlight)$artist^ca()";echo "^ca(1,/home/clement/.xmonad/scripts/dzen_albuminfo.sh)^fg()  Album:  ^fg($highlight)$album^ca()"; echo "^ca(1,/home/clement/.xmonad/scripts/dzen_lyrics.sh)  Year:   ^fg($highlight)$date^ca()"; echo "  $percbar"; echo "      ^ca(1, cmus-remote -r)  ^fg($white0)^i(/home/clement/.xmonad/dzen2/prev.xbm) ^ca()  ^ca(1, cmus-remote -u ) ^i(/home/clement/.xmonad/dzen2/pause.xbm) ^ca()  ^ca(1, cmus-remote -p) ^i(/home/clement/.xmonad/dzen2/play.xbm) ^ca()   ^ca(1, cmus-remote -n) ^i(/home/clement/.xmonad/dzen2/next.xbm) ^ca()"; echo " "; sleep 15) | dzen2 -fg $foreground -bg $background -fn $FONT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse,hide;button1=exit;button3=exit' & 
sleep 15
killall feh
