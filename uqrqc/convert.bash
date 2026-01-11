#!/bin/bash
FILE1=uqrq_mem_adjusted.txt
FILE2=uqrqc-g4bki-adjusted.txt

OUTFILE=UQRQC_db.txt
TMPFILE=.temp.txt

echo Processing $FILE1 $FILE2
dos2unix -q $FILE1 $FILE2

cat $FILE1 | sed 's/Ø/0/g' | gawk 'BEGIN {FS=" "} {printf("%s,%s\n", $2, $1)} END {}' > $TMPFILE

cat $FILE2 | sed 's/Ø/0/g' | gawk '\
BEGIN {
  FS=",";
}
{
  printf("%s,%s,%s\n", $1, $3, $2);
}
END {}' >> $TMPFILE

gawk '
BEGIN {
  printf("#00 U-QRQ-C Members prefill database\n");
  printf("#01 Scraped from https://u-qrq-c.ru/members-rus and https://qrz.com\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  if (calls[$1] == "") { # Not seen before
    if ($2 ~ /^[1-9]/ && $3 == "") {
      printf("New: \"%s\"\n", $0) > "/dev/stderr";
      calls[$1] = $1;
      printf("calls[\"%s\"]=\"%s\"\n", $1, calls[$1]) > "/dev/stderr";
      numbers[$1] = $2;
    } 
    else {
      printf("Ignored new: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else { # Seen before
    if (calls[$1] == $1 && numbers[$1] == $2 && $3 != "") {
      printf("Update with name: \"%s\"\n", $0) > "/dev/stderr";
      names[$1] = $3;
    } 
    else {
      printf("calls[\"%s\"]=\"%s\", $1=\"%s\"\n", $1, calls[$1], $1) > "/dev/stderr";
      printf("numbers[\"%s\"]=\"%s\", $2=\"%s\"\n", $1, numbers[$1], $2) > "/dev/stderr";
      printf("$3=\"%s\"\n", $3) > "/dev/stderr";

      printf("Ignored update: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  for (c in calls) {
    if (calls[c] != "") {
      printf("%s=%s;%s\n", calls[c], numbers[c], names[c]);
    }
  }
}' $TMPFILE | sort -n -t '=' -k2 |  sed 's/#0. /# /g' > $OUTFILE

exit

cat $FILE | sed 's/Ø/0/g' | gawk '
BEGIN {
  printf("#00 U-QRQ-C Members prefill database\n");
  printf("#01 Scraped from https://u-qrq-c.ru/members-rus and https://qrz.com\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=" ";
}
{
  printf("%s=%s\n", $2, $1);
}
END {
}' | sort | sed 's/#0. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
