#!/bin/bash
FILE=counties.txt
echo Parsing $FILE
OUTFILE1=mult-counties.txt
OUTFILE2=regex-counties.txt

dos2unix $FILE

# gawk '
# BEGIN {}
# {
  # name = toupper(substr($0,1,1)) tolower(substr($0,2));
  # cnt = toupper(substr($0,1,3));
  # printf("%s=%s\n", cnt, name);
# }
# END { }' $FILE | sort > $OUTFILE1
# echo Created $OUTFILE1
# unix2dos -q $OUTFILE1


gawk '
BEGIN {
  FS="=";
  printf("^(");
}
{
  cnt = $1
  printf("%s|", cnt);
}
END {
  printf(")$\n");
}' $OUTFILE1 | sed 's/|)/)/g' > $OUTFILE2
echo Created $OUTFILE2
unix2dos -q $OUTFILE2

exit
