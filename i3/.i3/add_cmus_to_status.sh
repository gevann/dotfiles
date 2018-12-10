#!/bin/sh
# shell script to prepend i3status with cmus song and artist
i3status | (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && while :
do
  read line
  artist=$(cmus-remote -Q | grep ' artist ' | cut -d ' ' -f3-)
  song=$(cmus-remote -Q | grep title | cut -d ' ' -f3-)
  status=$(cmus-remote -Q | grep status | cut -d ' ' -f 2)
  echo "CMUS($status): $song - $artist | $line" || exit 1
done)
