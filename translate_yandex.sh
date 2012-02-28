#!/bin/bash
# Translate text with Yandex API
_zenity="/usr/bin/zenity"
#_out="/tmp/translate.output.$$"

text=$(${_zenity} --title  "Enter text" --entry --entry-text="$(xclip -o)" )
#text=$(${_zenity} --title "Enter text" --entry --entry-text="$(xsel -o -p)" )

if [ $? -eq 0 ]
then
wget -qO- translate.yandex.ru/tr.json/translate --post-data="srv=tr-text&lang=en-ru&text=$text" | sed 's/"//g' | zenity --width=600 --height=240 --title "Translation for $text" --text-info

# wget -O ${_out} http://translate.yandex.ru/tr.json/translate --post-data="srv=tr-text&lang=en-ru&text=$text"
#  sed -i 's/"//g' ${_out}
#  ${_zenity} --width=600 --height=240  \
#         --title "Translation for $text" \
#         --text-info --filename=${_out}
#  /bin/rm ${_out}
fi
