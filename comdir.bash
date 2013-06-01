#!/bin/bash
#
# USAGE
#	comdir.bash [DIRECTORY] [DIRECTORY]
#
# DESCRIPTION
#	Compare all files within two directories. If two files with the same name
#	and path exist then compare the contents. If the same line exists in both
#	files then print the line.
#

shopt -s extglob	# TODO(PM): What if it was already on?
touch tmp	# TODO(PM): What if it already exists?

# Compare the contents of two directories and write into TMP
comm -12 <(cd $1 && find | sort) <(cd $2 && find | sort) > tmp

while read line; do
	file=$(echo $line | cut -c2-)
	extension="${file##*.}"
	if [[ $extension == @(txt|xml|json) ]]
	then
		echo -e "\n"
		echo $file
		comm -12 ./$1$file ./$2$file
	fi
done < tmp

rm tmp	# TODO(PM): What if it already existed?
shopt -u extglob	# TODO(PM): What if it was already on?
