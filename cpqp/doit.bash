#!/bin/bash

./makeregex.bash ALBERTA.txt > alberta-regex.txt
./makeregex.bash SASKATCHEWAN.txt > saskatchewan-regex.txt
./makeregex.bash MANITOBA.txt > manitoba-regex.txt
unix2dos -q *regex.txt
exit

