#!/bin/bash
# File 2 should be the newer
FILE1=`ls CNCW* | tail -1 2> /dev/null`
FILE2=`ls KING* | tail -1 2> /dev/null`
OUTFILE=EA_db.txt

echo "Parsing" $FILE1 $FILE2
dos2unix -q $FILE1 $FILE2

cat $FILE1 $FILE2 | sed 's/ //g' | gawk '
BEGIN {
  FS=","
  maxlen = 0;
  longest = "";
}
{
  multok = $2 ~ /^(SMR|A|AB|AL|AV|B|BA|BI|BU|C|CA|CC|CE|CO|CR|CS|CU|GC|GI|GR|GU|H|HQ|HU|IB|J|L|LE|LO|LU|M|MA|ML|MU|NA|O|OU|P|PO|S|SA|SE|SG|SO|SS|T|TE|TF|TO|V|VA|VI|Z|ZA)$/;
  if ($1 ~ /^[0-9,A-Z]/ && multok)
  {
    calls[$1] = $1;
    exch[$1] = $2;
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#0 Spanish provinces database including special exchanges HQ and SMR\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
  for (c in calls) 
  {
    printf("%s=%s\n", calls[c], exch[c]);
  }
}' | sort | sed 's/#. /# /g' | uniq > $OUTFILE
echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit
