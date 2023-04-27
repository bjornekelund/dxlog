BEGIN {
  printf("#0 CQ WW RTTY database - States and provinces but AK HI PR VI not included\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  exch = $3;
  if (exch == "PE") exch = "PEI";
  if (exch == "NT") exch = "NWT";
  if ($1 ~ /^[0-9A-Z\/]+$/ && exch ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NF|NS|NWT|NU|ON|PEI|QC|SK|YT)$/)
    printf("%s=%s\n", $1, exch);
  else if ($0 !~ /^(!|#|$)/ && exch != "")
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
