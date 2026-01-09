BEGIN {
  FS=" ";
  prevcall = "";
}
{
  call = $1;
  if (call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/) 
  {
    if (($call ~ /^(A[A-GIJK]|[KNW][A-GIM-OQ-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $call !~ /^V[A-GOXY]/ && $2 !~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
      ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $call !~ /^W[0-9]$/ && $2 !~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
    {
        printf("Ignore: \"%s\"\n", $0) > "/dev/stderr"
    }
    else 
    {
      exchange = $2;
      if (exchange ~ /^1?KW?$/) exchange = "KW";
      if (exchanges[call] != "" && exchanges[call] != exchange) {
	      # printf("For %s, %s is replaced by %s -> ignored\n", call, exchanges[call], exchange) > "/dev/stderr";
      }
      else
      {
        exchanges[call] = exchange;
        calls[call] = call;
      }
	  }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
  prevcall = call;
}
END {
  printf("#00 ARRL DX Contest prefill database\n");
  printf("#01 Based on data maintained by AD5Q\n");
#  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in calls) {
     printf("%s=%s\n", c, exchanges[c]);
  }
}
