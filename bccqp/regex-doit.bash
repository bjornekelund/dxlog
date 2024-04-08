#!/bin/bash
INFILE=bcc-members.txt
OUTFILE=BCC-regex.txt

echo Downloading $INFILE...
curl -sS https://www.bavarian-contest-club.de/data/bcc-members.txt -o $INFILE

echo Parsing $INFILE...
dos2unix -q $INFILE

sed 's/ //g' $INFILE | sort | gawk -b '
BEGIN {
  FS=",";
  first = 1;
  count = 0;
}
{
  call = toupper($1)
  if (call ~ /^[0-9,A-Z,\/]+$/) {
    if (first)
      string = call;
    else
      string = string  "|"  call;
    first = 0;
  }
}
END {
  printf("# Silent multiplier to highlight members in bandmap.\n");
  printf("# Member callsigns from https://www.bavarian-contest-club.de as of %s\n", strftime("%Y-%m-%d"));
  printf("MULT2_TYPE=CALLSIGN\n");
  printf("MULT2_COUNT=PER_MODE\n");
  printf("MULT2_FIELD=CALLSIGN\n");
  printf("MULT2_NO_ALERT=YES\n");
  printf("MULT2_EXCEPTION=!DEST->CALL:^(%s)$;NONE\n\n", string);

  printf("# Points calculation. Members are 2 points. Non-members are 1 point.\n");
  printf("# Member callsigns from www.bavarian-contest-club.de as of %s\n", strftime("%Y-%m-%d"));
  printf("POINTS_FIELD_BAND_MODE=ALL;DEST->DXCC:^$;ALL;ALL;0\n");
  printf("POINTS_FIELD_BAND_MODE=DEST->CALL:^DA0BCC$;ALL;ALL;ALL;5\n");
  printf("POINTS_FIELD_BAND_MODE=DEST->CALL:^(%s)$;ALL;ALL;ALL;2\n", string);
  printf("POINTS_FIELD_BAND_MODE=ALL;ALL;ALL;ALL;1\n\n");

}' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

