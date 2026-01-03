BEGIN {
  FS=","
  printf("#00 Ontario QSO Party database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/) 
  {
    call = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if ( \
      ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      ($call ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|PE|QC|SK|YT)$/) ||\
      ($call ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(ALG|BRA|BFD|BRU|CHK|COC|DUF|DUR|ELG|ESX|FRO|GRY|HAL|HLB|HTN|HAM|HAS|HUR|KAW|KEN|LAM|LAN|LGR|LXA|MAN|MSX|MUS|NIA|NIP|NFK|NOR|OTT|OXF|PSD|PEL|PER|PET|PRU|PED|RAI|REN|SIM|SDG|SUD|TBY|TIM|TOR|WAT|WEL|YRK)$/) )
  {
    if (line[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
    } 
    else if ($col !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|PE|QC|SK|YT)$/)
    {
      line[$call] = $0;
      printf("%s=%s\n", $call, $col);
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
} 
