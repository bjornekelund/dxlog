#!/bin/bash

FILE1=`ls VHF_U* | tail -1 2> /dev/null`
FILE2=`ls VHFREG* | tail -1 2> /dev/null`
LOCAL=LOCAL.txt

OUTFILE=vhf_uhf_r1_db.txt
OUTFILE4=vhf_uhf_r1_4_db.txt

dos2unix -q $FILE1 $FILE2

echo  Creating 6-position grid database by parsing $FILE2

# Equal sign separated file #1
cat $FILE1 | gawk '
BEGIN {
  FS="=";
  ignored = 0;
}
{
  if ($1 ~ /^[0-9,A-Z\/]{3,}$/ && $2 ~ /^[A-R][A-R][0-9][0-9]([A-X][A-X])?$/)
    printf("%s=%s\n", $1, $2);
  else {
    if ($2 != "" && $2 !~ /^[A-R][A-R][0-9][0-9]$/)
      printf("Ignored in file #1: \"%s\"\n", $0) > "/dev/stderr";
	ignored++;
  }
}
END {
  printf("%d calls ignored in file #1\n", ignored) > "/dev/stderr";

}' > .tmp1

# Comma separated file
cat $FILE2 | gawk '
BEGIN {
  FS=",";
  ignored = 0;
}
{
  if ($1 ~ /^[0-9,A-Z\/]{3,}$/ && $3 ~ /^[A-R][A-R][0-9][0-9]([A-X][A-X])?$/)
    printf("%s=%s\n", $1, $3);
  else {
    if ($3 != "" && $3 !~ /^[A-R][A-R][0-9][0-9]$/) 
      printf("Ignored in file #2: \"%s\"\n", $0) > "/dev/stderr";
	ignored++;
  }
}
END {
  printf("%d calls ignored in file #2\n", ignored) > "/dev/stderr";
}' > .tmp2

# Create 6-position grid file

cat .tmp1 .tmp2 $LOCAL | gawk '
BEGIN {
  FS="=";
  ignored = 0;
}
{
#  printf("Call=%s Grid=%s Status=%s\n", $1, $2, $3) > "/dev/stderr";
  if ($1 ~ /^[0-9,A-Z\/]{3,}$/ && $2 ~ /^[A-R][A-R][0-9][0-9][A-X][A-X]$/) {
	if ($2 != gridlist[$1] && gridlist[$1] != "") {
#	  printf("Younger file override. New value: %s = %s, was %s\n", $1, $2, gridlist[$1]) > "/dev/stderr";
	}
	callist[$1] = $1;
	gridlist[$1] = $2;
  }
  else {
#    printf("Grid6: Discarded 4-position grid \"%s\"\n", $0) > "/dev/stderr";
	ignored++;
  }
}
END {
  printf("#0 VHF/UHF 6-position grid data base\n");
  printf("#1 Credits to VE2FK, HB9THU, and ES7GM\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in callist)
    printf("%s=%s\n", callist[c], gridlist[c]);
  printf("Ignored %d calls with 4-character grids\n", ignored) > "/dev/stderr";
}'  | sort | sed 's/^\#. /\# /g' > $OUTFILE
echo $OUTFILE "created with" `cat $OUTFILE | wc -l` "calls"


echo ---------------

# Create 4-position grid file

cat .tmp1 .tmp2 $LOCAL | gawk '
BEGIN {
  FS="=";
  ignored = 0;
}
{
  grid = substr($2, 0, 4);
#  printf("Grid4: Call=%s Grid=%s\n", $1, grid) > "/dev/stderr";
  if ($1 ~ /^[0-9A-Z\/]{3,}$/ && grid ~ /^[A-R][A-R][0-9][0-9]$/) {
	if (grid != gridlist[$1] && gridlist[$1] != "") {
#	  printf("Younger file override. New value: %s = %s, was %s\n", $1, grid, gridlist[$1]) > "/dev/stderr";
	}
	callist[$1] = $1;
	gridlist[$1] = grid;
  }
  else {
    printf("Grid4: Discarded line \"%s\"\n", $0) > "/dev/stderr";
	ignored++;
  }
}
END {
  printf("#0 VHF/UHF 6-position grid data base\n");
  printf("#1 Credits to VE2FK, HB9THU, and ES7GM\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in callist)
    printf("%s=%s\n", callist[c], gridlist[c]);
  printf("Ignored %d calls\n", ignored) > "/dev/stderr";
}'  | sort | sed 's/^\#. /\# /g' > $OUTFILE4
echo $OUTFILE4 "created with" `cat $OUTFILE4 | wc -l` "calls"

unix2dos -q $OUTFILE $OUTFILE4

exit
