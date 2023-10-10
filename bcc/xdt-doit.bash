#!/bin/bash
INFILE=bcc-members.xdt
OUTFILE=BCC.xdt

echo Downloading $INFILE...
curl -sS https://www.bavarian-contest-club.de/data/bcc-members.xdt -o $OUTFILE

cp $OUTFILE ../xdt

echo Created $OUTFILE

exit

