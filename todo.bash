#!/bin/bash

# DESCRIPTION
#   Find all TODO comments in the Python source code files tracked by git

LFE=".py"   # Programming language file extension
LEN=3   # File extension length

for FILE in $(git ls-files)
do
    if [ ${FILE: -$LEN} == $LFE ] # Check for source files
    then
        grep TODO $FILE >/dev/null
        if [ $? -eq 0 ] # Check if file contains string
        then
            echo \## $FILE
            # Print lines containing string
            # and replace preceding text with nothing
            #TODO(PM) Markdown newline requires two spaces at the end
            # of a line
            grep TODO $FILE | sed 's/^.*TODO//g'
            echo    # Print new line
        fi
    fi
done
