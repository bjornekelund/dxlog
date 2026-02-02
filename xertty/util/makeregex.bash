#!/bin/bash
FILE=STATES.txt
OUTFILE=states-regex.txt

dos2unix -q $FILE

gawk 'BEGIN {FS = ",";printf("^(")}{if($0!~/^#/)printf("%s|", $1)}END{printf(")$\n");}' $FILE | sed 's/|)/)/g' > $OUTFILE

exit
