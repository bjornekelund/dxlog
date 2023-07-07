#!/bin/bash
INFILE=bcc-members.xdt
OUTFILE=BCC.xdt

echo Downloading $INFILE...
wget -q --no-hsts https://www.bavarian-contest-club.de/data/bcc-members.xdt -O $OUTFILE

cp $OUTFILE ../xdt

echo Created $OUTFILE

exit

