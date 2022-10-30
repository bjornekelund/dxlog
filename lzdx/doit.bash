#!/bin/bash
OLDFILE=prev-lzdx_db.txt
OLDTEMP=.prev-lzdx_db.txt
FILE=`ls LZDX-* | tail -1 2> /dev/null`
OUTFILE=lzdx_db.txt

dos2unix -q $FILE $OLDFILE
echo Converting $OLDFILE

gawk '
BEGIN {
  FS="=";
}
{
  if ($1 ~ /^[0-9,A-Z]/)
    printf("%s,,%s\n", toupper($1), toupper($2));
  else if ($0 !~ /^(!|#|$)/ && $2 != "")
    printf("Skipped: %s\n", $0) > "/dev/stderr";
}' $OLDFILE > $OLDTEMP

echo Parsing $FILE...

cat $OLDTEMP $FILE | gawk '
BEGIN {
  FS=","
  printf("#0 LZ DX Contest database\n");
  printf("#1 Based on data collected and maintained by VE2FK and R9IR\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9,A-Z]/ && $3 ~ /^(BU|BL|VN|VT|VD|VR|GA|DO|KA|KD|LV|MN|PA|PK|PL|PD|RZ|RS|SS|SL|SM|SF|SO|SZ|TA|HA|SN|YA)$/) {
    if (ex[$1] != "" && ex[$1] != $3)
      printf("Replacing %s with %s for %s\n", ex[$1], $3, $1) > "/dev/stderr";
    call[$1] = $1;
    ex[$1] = $3;
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "")
    printf("Skipped: %s\n", $0) > "/dev/stderr";
}
END {
  for (cl in call)
    printf("%s=%s\n", cl, ex[cl]);
}' | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

rm -rf $OLDTEMP

exit
