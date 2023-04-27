BEGIN {
  printf("#0 ARRL RTTY database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $3);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "") {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
