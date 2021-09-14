#/bin/bash
cd $(dirname $0)
INFILE=bcc-members.txt
OUTFILE=BCC-regex.txt

wget --no-hsts http://www.bavarian-contest-club.de/members/bcc-members.txt -O $INFILE

echo Parsing $INFILE...
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

