#!/bin/bash
INFILECW=`ls NAQPC* | tail -1 2> /dev/null`
INFILESSB=`ls NAQPS* | tail -1 2> /dev/null`
OUTFILECW=NAQP-CW_db.txt
OUTFILESSB=NAQP-SSB_db.txt
HELPERS=../1helpers/helpers.awk

echo Parsing $INFILECW
dos2unix -q $INFILECW

sed 's/ //g' $INFILECW | gawk -f $HELPERS -f naqp.awk | sort | sed 's/^#0. /# /g' > $OUTFILECW

unix2dos -q $OUTFILECW $INFILECW
echo Created $OUTFILECW

../copytosourcetree.sh $OUTFILECW

echo Parsing $INFILESSB
dos2unix -q $INFILESSB

sed 's/ //g' $INFILESSB | gawk -f $HELPERS -f naqp.awk | sort | sed 's/^#0. /# /g' > $OUTFILESSB

unix2dos -q $OUTFILESSB $INFILESSB
echo Created $OUTFILESSB

../copytosourcetree.sh $OUTFILESSB


LIST="mdqp mtqp fistsspr arrlrr"

for contest in $LIST; do
  echo ---------------
  cd ../$contest
  echo "Doing" $contest "in" `pwd`
  ./doit.sh
done

exit
