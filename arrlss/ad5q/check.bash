#!/bin/bash

dos2unix -q $1

cat $1 | gawk '{gsub(/  +/," "); sub(/^ /,""); sub(/ $/,"")}1' | gawk -f check.awk

exit
