BEGIN {
  FS=","
  printf("#0 Iowa QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 == "!!Order!!") {
    if ($2 ~ /Exch1/) col = 1;
	  if ($3 ~ /Exch1/) col = 2;
	  if ($4 ~ /Exch1/) col = 3;
	  if ($5 ~ /Exch1/) col = 4;
	  printf("\"%s\" --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } else {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      if ($1 ~ /^[0-9A-Z\/]+$/ && ($col ~ /^[A-Z]{3}$/) || $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|KS|KY|LA|ME|MD|MA|MI|MS|MN|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WI|WV|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) {
        printf("%s=%s\n", $1, $col);
        lines[$1] = $0;
      }
      else if ($0 !~ /^(!|#|$)/ && $col != "")
        printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
