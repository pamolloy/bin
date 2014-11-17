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

for FILE in "$@"; do
    LINE=$(identify -verbose "$FILE" | grep "DateTime:")
    IFS=$' '
    read -a ARRAY <<< "${LINE:4}"   # Split on ` ` and remove first 4 chars
    DATE="${ARRAY[1]}"
    TIME="${ARRAY[2]}"
    IFS=$':'
    read -a ARRAY <<< "${DATE}"
    YEAR="${ARRAY[0]}"
    MONTH="${ARRAY[1]}"
    DAY="${ARRAY[2]}"
    EPOCH="$(date --date="$MONTH/$DAY/$YEAR $TIME" "+%s")"
    EXTENSION="${FILE##*.}"
    mv $FILE "$EPOCH.$EXTENSION"
done
