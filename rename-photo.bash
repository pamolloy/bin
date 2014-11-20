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

for FILE in "$@"; do
    echo Processing $FILE
    LINE=$(identify -verbose "$FILE" | grep "DateTime:")
    echo EXIF output: $LINE
    if [ -z "$LINE" ]; then
        echo ERROR: Datetime not found in $FILE
    else
        IFS=$' '
        read -a ARRAY <<< "${LINE:4}"   # Split on ` ` and remove first 4 chars
        DATE="${ARRAY[1]}"
        TIME="${ARRAY[2]}"
        if [ -z "$TIME" ]; then echo ERROR: Time not found in $FILE; break; fi
        echo Time: $TIME
        IFS=$':'
        read -a ARRAY <<< "${DATE}"
        YEAR="${ARRAY[0]}"
        echo Year: $YEAR
        if [ -z "$YEAR" ]; then echo ERROR: Year not found in $FILE; break; fi
        MONTH="${ARRAY[1]}"
        echo Month: $MONTH
        if [ -z "$MONTH" ]; then echo ERROR: Month not found in $FILE; break; fi
        DAY="${ARRAY[2]}"
        echo Day: $DAY
        if [ -z "$DAY" ]; then echo ERROR: Day not found in $FILE; break; fi
        EPOCH="$(date --date="$MONTH/$DAY/$YEAR $TIME" "+%s")"
        EXTENSION="${FILE##*.}"
        mv $FILE "$EPOCH.$EXTENSION"
    fi
done
