BEGIN {
  printf("#00 WW PMC Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Exch1");
  # printf\("%s --> call=%d exch=%s\n", $0, call, exch) > "/dev/stderr";
  }
  else if (IsValidCall($call) && \
    $exch ~ /^(ABI|ANT|ARN|ASI|ATL|BNG|BAN|BCA|BEI|BEN|BER|BGT|BRV|BUA|CAC|CAM|CHA|CHI|COM|CON|COV|DAK|DEL|DHA|FIR|FRE|FHN|GEN|GMC|GVD|HAL|HEL|HIR|JEU|JER|KAL|KTS|KIE|KOB|KOE|KTR|KRA|KRU|KMV|KYR|HDL|LEF|LHA|LAM|LAP|LPS|LIB|LIG|LIM|LIS|LJA|LOM|LUB|MDI|MAP|MRH|MZO|MEL|MSL|MXY|MIL|MKE|MIN|MOR|MOS|NAB|NAG|NED|NEH|ORE|OSW|PAU|POK|PTV|POR|PLP|PRA|PUE|QIO|RAV|RIJ|ROM|HRO|SCA|SFR|SJO|SPE|SAR|SHE|SLG|SOI|SPA|SPL|SRK|STO|SUW|TAS|TBL|TOK|TOR|TON|VAN|VER|VIS|VLA|VOL|WAR|WLN|WIE|WOL|WRO|YSO|YOK|ZGB|ZUR)$/)
  {
    printf("%s=%s\n", $call, $exch);
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
