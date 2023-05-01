BEGIN {
  printf("#0 CQ 160M database - States and provinces\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $3 != "" && $3 ~ /^(CT|MA|ME|NH|RI|VT|NJ|NY|DE|PA|MD|DC|AL|FL|GA|KY|NC|SC|TN|VA|AR|LA|MS|NM|OK|TX|CA|AZ|ID|MT|NV|OR|UT|WA|WY|MI|OH|WV|IL|IN|WI|CO|IA|KS|MN|MO|ND|NE|SD|NB|NS|NF|PE|PEI|LB|QC|ON|MB|SK|AB|BC|NU|NT|NWT|YT|YUK)$/) {
    exch = $3;
#    if ($3 == "YUK") exch = "YT";
#    if ($3 == "NWT") exch = "NT";
#    if ($3 == "PEI") exch = "PE";
    printf("%s=%s\n", $1, exch);
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "")
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {}
