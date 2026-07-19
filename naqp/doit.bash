#!/bin/bash
INFILE=`ls NAQP[^_]* | tail -1 2> /dev/null`
OUTFILE=NAQP_db.txt
HELPERS=../1helpers/helpers.awk

echo Parsing $INFILE
dos2unix -q $INFILE

sed 's/ //g' $INFILE | gawk -f $HELPERS -f naqp.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.bash $OUTFILE

LIST="mdqp mtqp fistsspr arrlrr"

for contest in $LIST; do
  cd ../$contest
  echo "Doing" $contest "in" `pwd`
  ./doit.bash
  echo ---------------
done

exit
