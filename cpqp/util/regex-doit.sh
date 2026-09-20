#!/bin/bash
./break.sh
./makeregex.sh ALBERTA.txt > alberta-regex.txt
./makeregex.sh SASKATCHEWAN.txt > saskatchewan-regex.txt
./makeregex.sh MANITOBA.txt > manitoba-regex.txt
./makeregex.sh COUNTIES.txt > counties-regex.txt
unix2dos -q *regex.txt

exit

