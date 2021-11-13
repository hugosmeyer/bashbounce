#!/bin/bash
# updated the comment
 
trap ctrl_c INT
trap update_size WINCH

function mssleep() {
        pms=`date +%s%N | cut -c1-13`
        stop=$((pms+mssleep))
        while [ $pms -le $stop ] 
        do
                pms=`date +%s%N | cut -c1-13`
        done
}

function update_size() {
        clear
        maxx=$((`stty size | awk '{print $2}'` - 1))
        maxy=$((`stty size | awk '{print $1}'` - 2))
}
 
function ctrl_c() {
        exitnow="Y"
        pms=$stop

}

mssleep=100 && [ ! -z $2 ] && mssleep=$2
exitnow="N"
C="O" && [ ! -z $1 ] && C=$1
x=0 && y=0
dx=1 && dy=1
tput civis
update_size
while [ $exitnow == "N" ] 
do
         tput cup $y $x && echo " "
        x=$((x+dx))
        y=$((y+dy))
        tput cup $y $x && echo "$C"
        [ $x -ge $maxx -o $x -le 0 ] && dx=$((-1*dx))
        [ $y -ge $maxy -o $y -le 0 ] && dy=$((-1*dy))
        [ $x -ge $maxx ] && x=$maxx
        [ $y -ge $maxy ] && y=$maxy
        mssleep 
done
tput cvvis
clear
