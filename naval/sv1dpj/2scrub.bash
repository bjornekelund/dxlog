#!/bin/bash
FILE1=NAVAL_db.txt
FILE2=INORC_db.txt

echo Parsing $FILE1 $FILE2
dos2unix -q $FILE1 $FILE2

cat $FILE1 | sed 's/=/,/g' | sed 's/;/,/g' |
gawk '
BEGIN {
  FS=",";
}
{
  printf("%s,%s,\n", $1, $2);
}
END {}' | sort | sed 's/^\#. /\# /g' > tmp1.txt

cat $FILE2 | sed 's/=/,/g' | sed 's/;/,/g' |
gawk '
BEGIN {
  FS=",";
}
{
  printf("%s,%s,\n", $1, $2);
}
END {}' | sort | sed 's/^\#. /\# /g' > tmp2.txt

exit
