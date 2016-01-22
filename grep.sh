#!/bin/bash

OPTIONS=""

if [ "$SEARCHTYPE" == "starts" ]; then
    SEARCHSTRING="^$SEARCHSTRING";
fi

if [ "$SEARCHTYPE" == "ends" ]; then
    SEARCHSTRING="$SEARCHSTRING$";
fi

if [ "$IGNORECASE" == "true" ]; then
    OPTIONS="-i $OPTIONS";
fi

if [ "$INVERTMATCH" == "true" ]; then
    OPTIONS="-v $OPTIONS";
fi


cat /input/sourcefile/content | grep $OPTIONS "$SEARCHSTRING"
