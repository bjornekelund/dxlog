#!/bin/bash

FILE=`ls es7gm* | tail -1 2> /dev/null`

OUTFILE=vhf_uhf_r1_db.txt
OUTFILE4=vhf_uhf_r1_4_db.txt
OUTFILEN=VHFREG1-000.txt

dos2unix -q $FILE

echo Creating N1MM database by parsing $FILE

cat $FILE | sed -e 's/=/,/g' | gawk '
BEGIN {
  FS=","
}
{
  call = toupper($1);
  if (call ~ /^[0-9]?[A-Z]+[0-9]+[A-Z]+$/) {
    printf("%s\n", $0)
  }
  else {
    if ($0 !~ /^(!|#|$)/) {
      # printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
      ignored++;
    }
  }
}
END {
  printf("Ignored %d lines\n", ignored) > "/dev/stderr";
}' | sort > $OUTFILEN

echo Creating 6-position grid database by parsing $OUTFILEN

gawk '
BEGIN {
  printf("#00 VHF/UHF 6-position grid data base\n");
  printf("#01 Credits to VE2FK, HB9THU, and ES7GM\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
  ignored = 0;
}
{
  call = toupper($1);
  callok = call ~ /^[0-9]?[A-Z]+[0-9]+[A-Z]+$/;
  grid1 = toupper($2);
  grid1ok = grid1 ~ /^[A-R]{2}[0-9]{2}[A-X]{2}?$/
  if (callok && grid1ok) {
    if (calls[call] != "" && grids[call] != grid1) {
      printf("Replacing %s with %s for %s\n", grids[call], grid1, call) > "/dev/stderr";
    }
    calls[call] = call;
    grids[call] = grid1;
  }
  else {
    if ($0 !~ /^(!|#|$)/) printf("Bad entry in: \"%s\"\n", $0) > "/dev/stderr";
    ignored++;
  }
}
END {
  for (c in calls)
    printf("%s=%s\n", calls[c], grids[c]);
  printf("Ignored %d lines\n", ignored) > "/dev/stderr";
}'  $OUTFILEN | sort | sed 's/^\#0. /\# /g' > $OUTFILE

echo $OUTFILE "created with" `cat $OUTFILE | wc -l` "calls"


echo ---------------

# Create 4-position grid file

echo  Creating 4-position grid database by parsing $OUTFILEN

gawk '
BEGIN {
  printf("#0 VHF/UHF 4-position grid data base\n");
  printf("#1 Credits to VE2FK, HB9THU, and ES7GM\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
  ignored = 0;
}
{
  call = toupper($1);
  callok = call ~ /^[0-9]?[A-Z]+[0-9]+[A-Z]+$/;
  grid1 = toupper($2);
  grid1ok = grid1 ~ /^[A-R]{2}[0-9]{2}/
  if (callok && grid1ok) {
    if (calls[call] != "" && grids[call] != grid1) {
      printf("Replacing %s with %s for %s\n", grids[call], grid1, call) > "/dev/stderr";
    }
    calls[call] = call;
    grids[call] = substr(grid1,1,4);
  }
  else {
    if ($0 !~ /^(!|#|$)/) printf("Bad entry in: \"%s\"\n", $0) > "/dev/stderr";
    ignored++;
  }
}
END {
  for (c in calls)
    printf("%s=%s\n", calls[c], grids[c]);
  printf("Ignored %d lines\n", ignored) > "/dev/stderr";
}'  $OUTFILEN | sort | sed 's/^\#. /\# /g' > $OUTFILE4

echo $OUTFILE4 created with `cat $OUTFILE4 | wc -l` calls

unix2dos -q $OUTFILE $OUTFILE4

exit
