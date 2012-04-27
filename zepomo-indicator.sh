#!/bin/bash

function progress_bar {

   local i
   local varTime=$1
   local whatTime=$2
   i=0

   while [ $i -lt $((varTime * 2)) ]
   do
      echo $((i * 50/varTime))
      i=$((i+1))
      sleep 30
   done | zenity --text="$whatTime" --progress --auto-close
      
   beep -r 10 -f 1500 -l 200 -d 1000
   sleep 1
   beep -f 1500 -l 2000
}

function open_file {

   writer=$(zenity --entry --title="Select the editor" --text="What is your editor?" --entry-text "libreoffice")
   zOpenPath="$(zenity --file-selection)"
   if [ "$zOpenPath" != "" ]
   then
      $writer "$zOpenPath" &
   fi

}

if [ ! -x /usr/bin/zenity ]; then
   gksudo apt-get install zenity
fi

if [ ! -x /usr/bin/beep ]; then
   gksudo apt-get install beep
fi

zenity --info --text="Pomodoro Technique Counter"

POMODORO_TIME=$(zenity --entry --title="Pomodoro time" --text="Enter the time in minutes" --entry-text "25")
BREAK_TIME=$(zenity --entry --title="Break time" --text="Enter the time in minutes" --entry-text "5")
LONG_BREAK_TIME=$(zenity --entry --title="Long Break time" --text="Enter the time in minutes" --entry-text "20")

while [ answer != "0" ]
do

answer=$(zenity --list --radiolist --width=350 --height=300 \\
   --column "Selection" --column "Choice" --column "Description" \\
   FALSE 0 "Exit" FALSE 1 "Start Pomodoro" FALSE 2 "Break" \\ 
   FALSE 3 "Long Breaks" TRUE 4 "Open TodoToday List" )

   case $answer in
   0) break ;;
   1)
      progress_bar $POMODORO_TIME "Pomodoro Time"
   ;;
   2)
      progress_bar $BREAK_TIME "Break Time"
   ;;
   3)
      progress_bar $LONG_BREAK_TIME "Long Break Time"
   ;;
   4)
      open_file
   ;;
   *) break ;;
   esac
done
exit 0




