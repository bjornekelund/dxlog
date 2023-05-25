#!/bin/bash
OUTFILE=ASCHAMP_points.txt

gawk -f points.awk /dev/null > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit
