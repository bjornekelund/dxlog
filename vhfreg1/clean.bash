#!/bin/bash
FILE=`ls VHFREG* | tail -1 2> /dev/null`
LOCAL=LOCAL.txt

OUTFILE=VHFREG1-001.txt
OUTFILE4=VHFREG1_4-001.txt

dos2unix -q $FILE

echo  Creating 6-position grid database by parsing $FILE

# Create 6-position grid file
cat $FILE | gawk '
BEGIN {
  printf("!!Order!!,Call,UserText,Loc1,\n");
  printf("# VHF/UHF 6-position grid data base\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
  ignored = 0;
}
{
  grid1 = $3;
  grid2 = $4;
  grid1ok = grid1 ~ /^[A-R]{2}[0-9]{2}[A-X]{2}?$/
  grid2ok = grid2 ~ /^[A-R]{2}[0-9]{2}[A-X]{2}?$/
  if ($1 ~ /^[0-9]?[A-Z]+[0-9]+[A-Z]+$/ && grid1ok) {
    if (grid1ok && grid2ok && grid1 != grid2) {
      printf("Disagreeing grids for %s: %s and %s\n", $1, grid1, grid2) > "/dev/stderr";
      ignored++;
    }
    else {
      printf("%s,%s,%s\n", $1, $2, grid1);
    }
  }
  else {
    # if (grid1 != "" && $3 !~ /^[A-R][A-R][0-9][0-9]$/) 
      printf("Ignored in file #2: \"%s\"\n", $0) > "/dev/stderr";
	  ignored++;
  }
}
END {
  printf("%d calls ignored in file #2\n", ignored) > "/dev/stderr";
}' > $OUTFILE
exit

# Derive 4-position grid file
gawk '
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
}'  $OUTFILE > $OUTFILE4

echo $OUTFILE4 created with `cat $OUTFILE4 | wc -l` calls

unix2dos -q $OUTFILE $OUTFILE4

exit
