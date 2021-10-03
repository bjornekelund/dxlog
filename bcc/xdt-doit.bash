#!/bin/bash
INFILE=bcc-members.xdt
OUTFILE=BCC.xdt

echo Downloading $INFILE...
wget -q --no-hsts http://www.bavarian-contest-club.de/members/$INFILE -O $OUTFILE
echo Created $OUTFILE
exit

