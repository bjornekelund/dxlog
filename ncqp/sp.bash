#!/bin/bash
FILE=statesandprov.txt
OUTFILE1=mult-sp.txt
OUTFILE2=regex-sp.txt

echo Parsing $FILE
dos2unix $FILE

gawk '
BEGIN {}
{
  name = $2 " " $3 " " $4 " " $5;
  cnt = $1;
  printf("%s=%s\n", cnt, name);
}
END { }' $FILE | sort > $OUTFILE1
echo Created $OUTFILE1
unix2dos -q $OUTFILE1


gawk '
BEGIN {
  FS="=";
  printf("^(");
}
{
  cnt = $1;
  printf("%s|", cnt);
}
END {
  printf(")$\n");
}' $OUTFILE1 | sed 's/|)/)/g' > $OUTFILE2

echo Created $OUTFILE2
unix2dos -q $OUTFILE2

exit
