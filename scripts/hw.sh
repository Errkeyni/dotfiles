#!/bin/bash

diff() { 
    d=$(( $(date -d "$1" "+%s")-$(date -d "$2" "+%s") )); 
    [[ $d -le 0 ]] && echo $(( $d + 86400 )) || echo $d; 
}

two_digits() { [[ -z "$1" ]] && echo 00 || [[ "$1" -le 9 ]] && echo 0"$1" || echo "$1"; }

convert() { echo $1 "$(two_digits "$(($1 / 3600))")":"$(two_digits "$(($1 % 3600 / 60))")":"$(two_digits "$(($1 % 3600 % 60))")"; };

format() {  
    if [ $1 == 1800 ]; then 
        twmnc -c 'Arena in 30 minutes'
    fi
    if [ $1 == 900]; then 
        twmnc -c 'Arena in 15 minutes'
    fi
    if [ $1 == 600 ]; then 
        twmnc -c 'Arena in 10 minutes'
    fi
    if [ $1 == 300 ]; then 
        twmnc -c 'Arena in 5 minutes'
    fi
    if [ $1 == 60 ]; then 
        twmnc -c 'Arena in 1 minute'
    fi

    if [ $1 -le 3600 ]; then 
        if [ $1 -le 1800 ]; then 
            echo '<span color="#EB1313">'$3 $2'</span>' 
        else 
            echo '<span color="#44C7EB">'$3 $2'</span>'
        fi 
    else 
        echo '<span color="#FFFFFF">'$3 $2'</span>'
    fi
}

counter() {
    echo  "$(format ""$(convert ""$(diff "$1" "`date +"%Y-%m-%d %T"`")" ")"" "$2" )" 
}

c0="$(counter "`date +"%Y-%m-%d 02:00:00"`" "" )" 
c1="$(counter "`date +"%Y-%m-%d 05:00:00"`" "" )"
c2="$(counter "`date +"%Y-%m-%d 11:00:00"`" "" )"

echo $c0 $c1 $c2
