#!/bin/bash
#
#   todo.bash - Find all TODO comments in specified files tracked by git
#

ltd()
{
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
                # TODO(PM): Markdown newline requires two spaces at the EOL
                grep "# TODO" $FILE | sed 's/^.*TODO//g'
                echo    # Print new line
            fi
        fi
    done
}

# Main control flow
if [ -z "$1" ]
then
    echo WARNING: Please specify a file extension
    exit 84
else
    LFE=$1   # Programming language file extension
    LEN=${#LFE}   # File extension length
    ltd
fi

