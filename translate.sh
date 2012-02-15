#!/usr/bin/env bash
# notify-send -u critical "$(xsel -o)" "$(wget -U "Mozilla/5.0" -qO - "http://translate.google.com/translate_a/t?client=t&text=$(xsel -o | sed "s/[\"'<>]//g")&sl=auto&tl=ru" | sed 's/\[\[\[\"//' | cut -d \" -f 1)"

BUF="$(xsel -o | sed "s/[\"'<>]//g")" 
notify-send -i /usr/local/share/ico.jpg -u critical "$(xsel -o)" "$(python /usr/bin/trans.py "$(xsel -o | sed "s/[\"'<>]//g")")"
# echo "$BUF" | festival --tts
# http://translate.google.com/translate_tts?ie=UTF-8&q=rename%20me%20or%20he&tl=en&prev=input 
wget -U "Mozilla/5.0" -qO-  "http://translate.google.com/translate_tts?q=$BUF&t=UTF-8&tl=en&prev=input" | mpg123 -q -
