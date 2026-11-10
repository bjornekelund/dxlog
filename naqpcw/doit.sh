#!/bin/bash
INFILE=$(ls NAQPC* | tail -1 2> /dev/null)
OUTFILE=NAQP_CW_db.txt
HELPERS=../_helpers/helpers.awk

echo Parsing $INFILE
dos2unix -q $INFILE

sed 's/ //g' $INFILE | gawk -f $HELPERS -f naqpcw.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

../copytosourcetree.sh $OUTFILE

CONTESTST="mdqp mtqp"
for contest in $CONTESTST; do
  echo ---------------
  cd ../$contest
  echo "Doing" $contest "in"$(pwd)
  ./doit.sh
done

exit
