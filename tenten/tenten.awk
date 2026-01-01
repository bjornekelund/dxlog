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
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~ /^([a-zA-Z]*|)$/ && $3 ~ /^[A-Z]+|$/ && $4 ~ /^([0-9]*|)$/)
  {
    if (calls[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$1], $0) > "/dev/stderr"
    }
    calls[$1] = $1;
    name[$1] = toupper($2);
    line[$1] = $0;
    if ($3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
      state[$1] = $3;
    else
      state[$1] = "";
    num[$1] = $4;
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