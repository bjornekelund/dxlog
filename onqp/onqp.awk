BEGIN {
  FS=","
  printf("#0 Ontario QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else {
    if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|CJ)/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|NT|NU|PE|QC|SK|YT|ALG|BRA|BFD|BRU|CHK|COC|DUF|DUR|ELG|ESX|FRO|GRY|HAL|HLB|HTN|HAM|HAS|HUR|KAW|KEN|LAM|LAN|LGR|LXA|MAN|MSX|MUS|NIA|NIP|NFK|NOR|OTT|OXF|PSD|PEL|PER|PET|PRU|PED|RAI|REN|SIM|SDG|SUD|TBY|TIM|TOR|WAT|WEL|YRK)$/) {
      if (line[$1] != "") {
        printf("\"%s\" reoccurs as \"%s\"\n", line[$1], $0) > "/dev/stderr";
      } 
      else {
        line[$1] = $0;
        printf("%s=%s\n", $1, $col);
      }
    }
    else if ($0 !~ /^(!|#|$)/ && $col != "")
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
