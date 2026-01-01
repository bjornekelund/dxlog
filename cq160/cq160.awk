BEGIN {
  printf("#0 CQ 160M database - States and provinces\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if (($1 ~ /^(A[A-L]|[KNW][A-Z]?|4U)[0-9]|\/W[0-9]$/ && $3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(V[A-EOY]|C[FGJ]|X[LM])[0-9]|\/V[EOY][0-9]$/ && $3 ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    exch = $3;
#    if ($3 == "YUK") exch = "YT";
#    if ($3 == "NWT") exch = "NT";
#    if ($3 == "PEI") exch = "PE";
    if ($3 !~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) 
    {
      printf("%s=%s\n", $1, exch);
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
