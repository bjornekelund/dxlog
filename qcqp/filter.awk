BEGIN {
  printf("#00 Quebec QSO Party prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) state = 2;
    if ($4 ~ /Exch1/) state = 3;
    if ($5 ~ /Exch1/) state = 4;
  # printf\("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ( \
    (IsUScall($call) &&
      $state ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    (IsVEcall($call) && \
      ($state ~ /^(AB|BC|LB|MB|NB|NF|NWT|NS|NU|ON|PE|SK|YT)$/ || \
      $state ~ /^(BSA|SLS|QUE|MAU|ETE|MTL|OTS|ATE|CND|NDQ|GIM|CAS|LVL|LDE|LNS|MEE|CDQ)(\/(BSA|SLS|QUE|MAU|ETE|MTL|OTS|ATE|CND|NDQ|GIM|CAS|LVL|LDE|LNS|MEE|CDQ))?$/ ||\
      $state ~ /^(ALG|BRA|BFD|BRU|CHK|COC|DUF|DUR|ELG|ESX|FRO|GRY|HAL|HLB|HTN|HAM|HAS|HUR|KAW|KEN|LAM|LAN|LGR|LXA|MAN|MSX|MUS|NIA|NIP|NFK|NOR|OTT|OXF|PSD|PEL|PER|PET|PRU|PED|RAI|REN|SIM|SDG|SUD|TBY|TIM|TOR|WAT|WEL|YRK)(\/(ALG|BRA|BFD|BRU|CHK|COC|DUF|DUR|ELG|ESX|FRO|GRY|HAL|HLB|HTN|HAM|HAS|HUR|KAW|KEN|LAM|LAN|LGR|LXA|MAN|MSX|MUS|NIA|NIP|NFK|NOR|OTT|OXF|PSD|PEL|PER|PET|PRU|PED|RAI|REN|SIM|SDG|SUD|TBY|TIM|TOR|WAT|WEL|YRK))?$/) \
    ))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableQCQP($call, $state))
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call) && $state != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

