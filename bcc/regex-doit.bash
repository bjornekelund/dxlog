#/bin/bash
cd $(dirname $0)
INFILE=`ls bcc-mem* 2> /dev/null`
OUTFILE=BCC-regex.txt

echo Using $INFILE
dos2unix -q $INFILE

gawk '
BEGIN {
  FS=",";
  printf("POINTS_FIELD_BAND_MODE=DEST->CALL:^(");
  notfirst = 0;
  count = 0;
}
{
  if (++count % 50 == 0) {
    printf(")$;ALL;ALL;ALL;2\nPOINTS_FIELD_BAND_MODE=DEST->CALL:^(");
    notfirst = 0;
  }
  call = toupper($1)
  if (call ~ /^[0-9,A-Z,\/]+$/) {
    if (notfirst)
      printf("|");
    notfirst = 1;
    printf("%s", call);
  }
}
END {
  printf(")$;ALL;ALL;ALL;2\n");
}' $INFILE > $OUTFILE
echo $OUTFILE created
unix2dos -q $OUTFILE
exit

