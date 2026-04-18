#!/bin/bash
OUTFILE=WTZC_points.txt

gawk -f points.awk > $OUTFILE < /dev/null

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
