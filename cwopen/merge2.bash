#!/bin/bash
FILE1=`ls ../cwt/CWOPS* | tail -1 2> /dev/null`
FILE2=CWO_2024-KA5M.txt
OUTFILE=CWOPSOPEN_2024-001.txt

echo Parsing $FILE1 $FILE2
dos2unix -q $FILE1 $FILE2

#cat $FILE1 $FILE2 | awk '{if ($0 !~ /^(!|#|$)/) printf("%s\n", $0);}' | sort > temp1.txt

cat $FILE1 $FILE2 |\
awk 'BEGIN {
  FS=","
  col = 2;
  dupes = 0;
  maxlen = 0;
}
{
  if ($0 ~ /!!Order!!/) {
    if ($2 ~ /Name/) col = 1;
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    newname = toupper($col);
    if ($1 ~ /^[0-9A-Z/]+$/ && newname ~ /^[A-Z]+$/) {
      if (length(newname) > maxlen) {
        maxlen = length(newname);
        maxname = newname;
      }
      if (name[$1] != $col && name[$1] != newname && name[$1] != "") {
        printf("Name conflict: %s and %s for %s\n", name[$1], newname, $1) > "/dev/stderr";
        dupes++;
      }
      name[$1] = newname;
      calls[$1] = $1;
    }
    else if ($0 !~ /^(!|#|$)/ && newname != "") {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END { 
  printf("#0 CWOps Open database\n");
  printf("#1 Last updated %s\n", strftime("%Y-%m-%d"));
  printf("#!!Order!!,Call,Name\n");
  for (call in calls)
    printf("%s,%s\n", call, name[call]);
  printf("Overwrote %d duplicate entries.\n", dupes) > "/dev/stderr";
  printf("Longest name is \"%s\" (%d)\n", maxname, maxlen) > "/dev/stderr";
}
{}' | sort | sed 's/#!!/!!/g' | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
