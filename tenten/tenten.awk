BEGIN {
  printf("#0 10-10 QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
  maxlen = 0;
  longest = "";
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Name/) nm = 2;
    if ($4 ~ /Name/) nm = 3;
    if ($5 ~ /Name/) nm = 4;
    if ($3 ~ /Exch1/) ex = 2;
    if ($4 ~ /Exch1/) ex = 3;
    if ($5 ~ /Exch1/) ex = 4;
    if ($3 ~ /Misc/) mi = 2;
    if ($4 ~ /Misc/) mi = 3;
    if ($5 ~ /Misc/) mi = 4;
    printf("%s --> name is column %d, exchange is column %d, miscellanous is column %d\n", $0, nm, ex, mi) > "/dev/stderr";
  } 
  else if ( \
    $1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $2 ~ /^([a-zA-Z]*|)$/ && $3 ~ /^[A-Z]+|$/ && $4 ~ /^([0-9]*|)$/)
  {
    if (calls[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$1], $0) > "/dev/stderr"
    }
    calls[$1] = $1;
    name[$1] = toupper($nm);
    line[$1] = $0;
    num[$1] = $mi;
    if ($3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      state[$1] = $ex;
    }
    else
    {
      state[$1] = "";
    }
    if (length($2) > maxlen) 
    {
      maxlen = length($2);
      longest = $2;
    }
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("Longest name is %s (%d)\n", longest, maxlen) > "/dev/stderr";
  for (c in calls) 
  {
    printf("%s=%s;%s;%s\n", calls[c], name[c], num[c], state[c]);
  }
}