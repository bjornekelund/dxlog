#!/bin/bash

#FILE=`ls VHF_U* | tail -1 2> /dev/null`
INFILE=`ls clean/VHFREG1-* | tail -1 2> /dev/null`
INFILE4=`ls clean/VHFREG1_4-* | tail -1 2> /dev/null`

OUTFILE=vhf_uhf_r1_db.txt
OUTFILE4=vhf_uhf_r1_4_db.txt

dos2unix -q $INFILE

echo  Creating 6-position grid database by parsing $INFILE

# Create 6-position grid file

gawk '
BEGIN {
  printf("#0 VHF/UHF 6-position grid data base\n");
  printf("#1 Credits to VE2FK, HB9THU, and ES7GM\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
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
}'  $INFILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created with" `cat $OUTFILE | wc -l` "calls"


echo ---------------

# Create 4-position grid file

echo  Creating 4-position grid database by parsing $INFILE4

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
}'  $INFILE4 | sort | sed 's/^\#. /\# /g' > $OUTFILE4

echo $OUTFILE4 created with `cat $OUTFILE4 | wc -l` calls

unix2dos -q $OUTFILE $OUTFILE4

../copytosourcetree.bash $OUTFILE
../copytosourcetree.bash $OUTFILE4

exit
