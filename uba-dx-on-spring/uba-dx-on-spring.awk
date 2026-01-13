BEGIN {
  printf("#00 Belgian UBA sections prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = "=";
}
{
  if ( \
    $1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $2 ~ /^(XXX|AAA|ACC|ALT|ARA|ARC|ATH|ATO|BDX|BLW|BRC|BSE|BTS|BXE|CDZ|CLR|CPN|CRD|DNZ|DRC|DST|EKO|ERA|GBN|GBX|GDV|GNT|GTM|HAC|HCC|HOB|HRT|IPR|KSD|KTK|LGE|LIR|LLV|LUS|LVN|MCL|MLB|MNS|MTT|MWV|NBT|NLB|NMR|NNV|NOK|NOL|ODE|ONZ|ORA|OBR|OSA|OSB|OST|PHI|RAC|RAF|RAM|RAT|RBO|RCA|RCN|REM|RST|RSX|SNW|TLS|TOR|TRA|TRC|TWS|UBA|VHF|WLD|WRA|WRC|WTO|ZLB|ZOV|ZLZ|ZTM)$/) 
  {
    if (lines[$1] != "" && exch[$1] != $2) 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s=%s\n", $1, $2);
      lines[$1] = $0;
      exch[$1] = $2;
    }
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
