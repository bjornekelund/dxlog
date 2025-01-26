BEGIN {
  FS="="
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~ /^(XXX|AAA|ACC|ALT|ARA|ARC|ATH|ATO|BDX|BLW|BRC|BSE|BTS|BXE|CDZ|CLR|CPN|CRD|DNZ|DRC|DST|EKO|ERA|GBN|GBX|GDV|GNT|GTM|HAC|HCC|HOB|HRT|IPR|KSD|KTK|LGE|LIR|LLV|LUS|LVN|MCL|MLB|MNS|MTT|MWV|NBT|NLB|NMR|NNV|NOK|NOL|ODE|ONZ|ORA|OBR|OSA|OSB|OST|PHI|RAC|RAF|RAM|RAT|RBO|RCA|RCN|REM|RST|RSX|SNW|TLS|TOR|TRA|TRC|TWS|UBA|VHF|WLD|WRA|WRC|WTO|ZLB|ZOV|ZLZ|ZTM)$/) {
    printf("%s=%s\n", $1, $2);
  }
  else
    if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#0 Database with UBA sections for UBA Spring Contest and UBA ON Contest\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}