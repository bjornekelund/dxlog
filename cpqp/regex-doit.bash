#!/bin/bash
./break.bash
./makeregex.bash ALBERTA.txt > alberta-regex.txt
./makeregex.bash SASKATCHEWAN.txt > saskatchewan-regex.txt
./makeregex.bash MANITOBA.txt > manitoba-regex.txt
./makeregex.bash COUNTIES.txt > counties-regex.txt
unix2dos -q *regex.txt

exit

