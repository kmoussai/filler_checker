#!/bin/sh
GREEN='\033[0;32m'
RESET='\033[0m'
RED='\033[0;31m'
#path of your player
MYPLAYER="./players/khalid.filler"
MYPLAYER_NUMBER=2
PLAYERS="carli.filler abanlin.filler champely.filler grati.filler hcao.filler superjeannot.filler"
PLAYER_NUMBER=1
#Map here <map00 map01 map02>
MAP="map01"
COUNT=5
Total=0
batle=0

for PLAYER in $PLAYERS
do
    win=0
    echo $PLAYER" VS "$MYPLAYER" In $MAP"
    # all battle historique is in trace folder
    MPATH=trace/$PLAYER/$MAP
    nothing=`mkdir -p $MPATH/`
    for i in `seq 1 $COUNT`
    do
        ./filler_vm -p$MYPLAYER_NUMBER $MYPLAYER -f maps/$MAP -p$PLAYER_NUMBER players/$PLAYER > $MPATH/$i 
        res=`tail -2 $MPATH/$i | cut -f4 -d ' '`
        x_score=`echo $res | cut -f2 -d ' '`
        o_score=`echo $res | cut -f1 -d ' '`
        if [ $MYPLAYER_NUMBER -eq 2 ]
        then
            if [ $x_score -gt $o_score ]
            then
                printf "${GREEN}"
                let 'win++'
            else
                printf "${RED}"
            fi
        else
            if [ $o_score -gt $x_score ]
            then
                printf "${GREEN}"
                let 'win++'
            else
                printf "${RED}"
            fi
        fi
        echo "      x score = $x_score, o score = $o_score${RESET}"
    done
    let 'Total=Total+win'
    let 'batle=batle+COUNT'
    echo "$win/$COUNT"
done
echo "total win is $Total/$batle"
