#!/bin/bash

STRING=""
for I in $*; do
   TYPE=$(echo $I | cut -c -1)
   if [ "$TYPE" == "R" ]; then
        FILTRO=".restrictions.$I"
        RESTRICTION=$(cat search-db.json | jq "$FILTRO" | sed 's/,/ /g' | sed 's/\[//g' | sed 's/\]//g' | sed 's/^"//g' | sed 's/"$//g')
        if [ "$STRING" == "" ]; then
                STRING="$RESTRICTION"
        else
                STRING="$STRING $RESTRICTION"            
        fi
   else
        FILTRO=".keys.$I"
        KEY=$(cat search-db.json | jq "$FILTRO" | sed 's/,/ OR/g' | sed 's/\[//g' | sed 's/\]//g' )
        if [ "$STRING" == "" ]; then
                STRING="($KEY)"
            else
                STRING="$STRING AND ($KEY)"            
        fi
   fi
done

echo $STRING
echo $STRING | xclip -selection c
