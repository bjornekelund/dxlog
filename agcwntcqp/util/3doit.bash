#!/bin/bash
AGCWDIR=../agcw
AGCWDB=Mitglieder.csv
NTCDIR=../ntc
SUMFILE=agcwntc.txt
HERE=`pwd`
OUTFILE=AGCW-NTCQP-NEW.txt

cd $NTCDIR
NTCDB=`ls NTC_QP* | tail -1 2> /dev/null`
cd $HERE

cp $AGCWDIR/$AGCWDB $NTCDIR/$NTCDB .
dos2unix -q $AGCWDB $NTCDB

cat $AGCWDB | gawk 'BEGIN {
  FS = ";";
}
{
# Format is # AGCW#;VORNAME;RUFZ
  if ($3 ~ /^[0-9,A-Z\/]+$/ && $1 ~/[0-9]+/)
    printf("%s,%s,%s\n", $3, $2, "AGCW" $1, $2);
  else if ($0 !~ /^(#|!|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}' > $SUMFILE

cat $NTCDB | gawk '
BEGIN {
  FS = ",";
}
{
# Format is # Call,Name,Number
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 ~/[0-9]+/)
    printf("%s,%s,%s\n", $1, $2, "NTC" $3);
  else if ($0 !~ /^(#|!|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}' >> $SUMFILE

cat $SUMFILE | gawk '
BEGIN {
  FS = ",";
  maxlen = 0;
}
{
# Format call,name,memberno,name
  name = $2;
  nameok = name ~ /^[A-Za-z]{2,10}$/ && name !~ /club/i;
  callok = $1 ~ /^[0-9,A-Z,\/]+$/;
  hyphenated = $2 ~ /^[A-Za-z]{2,10}[\- ][A-Za-z]{2,10}$/;


  if (callok)
  {
    if (nameok)
    {
      if (calls[$1] == "")
      {
        # First membership
        calls[$1] = $1;
        names[$1] = name;
        mem1[$1] = $3;
      }
      else
      {
        calls[$1] = $1;
        if (names[$1] != name)
        {
          printf("Name overwrite for %s: \"%s\" --> \"%s\"\n", $1, names[$1], name) > "/dev/stderr";
        }
        names[$1] = name;
        mem2[$1] = $3;     
      }
    }
    else
    {
      printf("Problem name \"%s\" for %s\n", $2, $1) > "/dev/stderr";
    }

  }
}
END {
#  printf("Not counting hyphenated names, %s has the longest: \"%s\" (%d)\n", maxcall, maxname, maxlen) > "/dev/stderr";
  printf("# AGCW-NTC Friendship QSO Party prefill database\n");
#  printf("# Based on call history data maintained by VE2FK\n");
#  printf("# Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));

  for (c in calls)
    printf("%s=%s;%s;%s\n", calls[c], names[c], mem1[c], mem2[c]);
}' | sort > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
