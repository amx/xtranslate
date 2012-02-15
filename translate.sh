#!/usr/bin/env bash

# old version
# notify-send -u critical "$(xsel -o)" "$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$(xsel -o | sed "s/[\"'<>]//g")&sl=auto&tl=ru" | sed 's/\[\[\[\"//' | cut -d \" -f 1)"

BUF="$(xsel -o | sed "s/[\"'<>]//g")" 
sLNG=$1
tLNG=$2

notify-send -i /usr/local/share/ico.jpg -u critical "$(xsel -o)" "$(python /usr/bin/trans.py $sLNG $tLNG $BUF)"
# echo "$BUF" | festival --tts
wget -U "Mozilla/5.0" -qO-  "http://translate.google.com/translate_tts?q=$BUF&t=UTF-8&tl=$tLNG&prev=input" | mpg123 -q -
