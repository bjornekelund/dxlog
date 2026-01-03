BEGIN {
  printf("#00 QCQP database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /!!Order!!/) 
  {
    call = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  } 
  else if ( \
    ($call ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3})|^(KL7|KH6|W[0-9])\/|\/W[0-9]$|^4U1WB$/ && $call !~ /\/V[EOY][0-9]$/ && $col ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    ($call ~ /^(V[A-EOXY]|C[F-KY]|X[LM])[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$/ && $col ~ /^(NS|ON|MB|SK|AB|BC|NT|NB|NL|NU|YT|PE)$/) || \
    ($call ~ /^(V[A-EOXY]|C[F-KY]|X[LM])[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$/ && $col ~ /^(BSA|SLS|QUE|MAU|ETE|MTL|OTS|ATE|CND|NDQ|GIM|CAS|LVL|LDE|LNS|MEE|CDQ)(\/(BSA|SLS|QUE|MAU|ETE|MTL|OTS|ATE|CND|NDQ|GIM|CAS|LVL|LDE|LNS|MEE|CDQ))?$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(NS|ON|MB|SK|AB|BC|NT|NB|NL|NU|YT|PE)$/)
    {
      printf("%s=%s\n", $call, $col);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
} 

