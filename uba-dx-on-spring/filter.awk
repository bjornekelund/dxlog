BEGIN {
  printf("#00 Belgian UBA sections prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Exch1|Sect");
    # printf("\"%s\" --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ( \
    IsValidCall($call) && \
    $exch ~ /^(XXX|AAA|ACC|ALT|ARA|ARC|ATH|ATO|BDX|BLW|BRC|BSE|BTS|BXE|CDZ|CLR|CPN|CRD|DNZ|DRC|DST|EKO|ERA|GBN|GBX|GDV|GNT|GTM|HAC|HCC|HOB|HRT|IPR|KSD|KTK|LGE|LIR|LLV|LUS|LVN|MCL|MLB|MNS|MTT|MWV|NBT|NLB|NMR|NNV|NOK|NOL|ODE|ONZ|ORA|OBR|OSA|OSB|OST|PHI|RAC|RAF|RAM|RAT|RBO|RCA|RCN|REM|RST|RSX|SNW|TLS|TOR|TRA|TRC|TWS|UBA|VHF|WLD|WRA|WRC|WTO|ZLB|ZOV|ZLZ|ZTM)$/)
  {
    if (lines[$call] != "")
    {
      # printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $exch);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    # printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
