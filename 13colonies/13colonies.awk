BEGIN {
  FS=","
  printf("#0 13 Colonies Special Event database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($2 ~ /Exch1/) col = 1;
	if ($3 ~ /Exch1/) col = 2;
	if ($4 ~ /Exch1/) col = 3;
	if ($5 ~ /Exch1/) col = 4;
	printf("\"%s\" --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9A-Z/]+$/ && $col ~ /^(DX|F|G|AL|AK|AR|AZ|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/ && $col != "")
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
