#!/bin/sh

MIN=20
MAX=80

COLOR=7

while [ true ]
do
    PERC=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1) # grab percentage with regex
    STATUS=$(pmset -g batt | grep -Eo '\w+;') # grab "charging;" or "discharging;" with regex
    INT_PERC=$(($PERC/10))

    if [ $PERC -lt $MIN -a $STATUS = "discharging;" ] # if perc < min and status == "discharging;"
    then
        COLOR=3
        echo '\007\c' # beep

    elif [ $PERC -gt $MAX -a $STATUS = "charging;" ]
    then
        COLOR=3
        echo '\007\c' # beep

    else
        COLOR=7
    fi

    tput setaf $COLOR; echo "\n%$PERC [\c"
  
    for i in `seq 1 $INT_PERC`
    do
        tput setaf 2; echo "+\c"
    done

    for i in `seq 1 $((10-$INT_PERC))`
    do
        tput setaf 1; echo "-\c"
    done

    tput setaf $COLOR; echo "]"

    sleep 5
done
