#!/bin/bash
QPFILE=AGCWNTCQP_db.txt
N1MMFILE=AGCW-NTCQP-NEW.txt

echo Parsing $QPFILE
dos2unix -q $QPFILE

echo !!Order!!,Call,Name,Exch1,Misc,UserText, > $N1MMFILE
echo "# AGCW-NTCQP" >> $N1MMFILE
echo "# If your (on the air) name is wrong, contact PA3HEN" >> $N1MMFILE
echo "# Send any info, corrections direct to pa3hen@gmail.com" >> $N1MMFILE
echo "# Use UDC file AGCW-NTCQP by G4OGB" >> $N1MMFILE

cat $QPFILE | sed 's/[=;]/,/g' | gawk '\
BEGIN { FS=","; }
{
  if ($0 ~ /^#/) 
  {
    if ($0 ~ / AGCW /)
    {
        print $0;
    }
  }
  else
  {
    printf ("%s,%s,%s,%s,%s\n", $1, $2, $3, $4, $5);
  }
}' >> $N1MMFILE

exit

echo Parsing $NTCFILE
dos2unix -q $NTCFILE

cat $NTCFILE | sed 's/[ \t]*$//' | sed 's/ ;/;/g' | gawk -f ntc.awk > $TEMP2

echo Parsing $QPFILE
dos2unix -q $QPFILE

cat $QPFILE | sed 's/ü/u/g' |  sed 's/é/e/g' | gawk -f qp.awk > $TEMP3

echo Creating $OUTFILE

cat $TEMP1 $TEMP2 $TEMP3 | gawk -f newagcwntcqp.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Done

../copytosourcetree.bash $OUTFILE

exit
