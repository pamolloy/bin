#!/bin/bash
#
# NAME
#   rename-photo.bash - Rename a photo using the datetime it was taken
#
# SYNOPSIS
#   rename-photo.bash FILE
#
# DESCRIPTION
#   Rename a photo to the datetime it was taken formatted as seconds since the
#   Epoch
#
# EXAMPLE
#   Rename more than one file using a wildcard
#
#       $ rename-photo.bash *.jpg
#

for FILENAME in "$@"; do
    echo Processing $FILENAME
    LINE=$(identify -verbose "$FILENAME" | grep "DateTime:")
    echo EXIF output: $LINE
    if [ -z "$LINE" ]; then
        echo ERROR: Datetime not found in $FILENAME
    else
        IFS=$' '
        read -a ARRAY <<< "${LINE:4}"   # Split on ` ` and remove first 4 chars
        DATE="${ARRAY[1]}"
        TIME="${ARRAY[2]}"
        if [ -z "$TIME" ]; then echo ERROR: Time not found in $FILENAME; break; fi
        echo Time: $TIME
        IFS=$':'
        read -a ARRAY <<< "${DATE}"
        YEAR="${ARRAY[0]}"
        echo Year: $YEAR
        if [ -z "$YEAR" ]; then echo ERROR: Year not found in $FILENAME; break; fi
        MONTH="${ARRAY[1]}"
        echo Month: $MONTH
        if [ -z "$MONTH" ]; then echo ERROR: Month not found in $FILENAME; break; fi
        DAY="${ARRAY[2]}"
        echo Day: $DAY
        if [ -z "$DAY" ]; then echo ERROR: Day not found in $FILENAME; break; fi
        EPOCH="$(date --date="$MONTH/$DAY/$YEAR $TIME" "+%s")"
        EXTENSION="${FILENAME##*.}"
        mv $FILE "$EPOCH.$EXTENSION"
    fi
done
