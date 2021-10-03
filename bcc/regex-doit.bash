#!/bin/bash
INFILE=bcc-members.txt
OUTFILE=BCC-regex.txt

echo Downloading $INFILE...
wget -q --no-hsts http://www.bavarian-contest-club.de/members/bcc-members.txt -O $INFILE

echo Parsing $INFILE...
dos2unix -q $INFILE

sed 's/ //g' $INFILE | sort | gawk '
BEGIN {
  FS=",";
  printf("# Points calculation. Members are 2 points. Non-members are 1 point.\n");
  printf("# Member callsigns from www.bavarian-contest-club.de\n");
  printf("POINTS_FIELD_BAND_MODE=ALL;DEST->DXCC:^$;ALL;ALL;-1\n");
  printf("POINTS_FIELD_BAND_MODE=DEST->CALL:^DA0BCC$;ALL;ALL;ALL;5\n");
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
  printf("POINTS_FIELD_BAND_MODE=ALL;ALL;ALL;ALL;1\n");
}' > $OUTFILE
echo $OUTFILE created
unix2dos -q $OUTFILE
exit

