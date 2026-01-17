BEGIN {
  printf("#00 WW PMC Contest prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> call=%d col=%s\n", $0, call, col) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $col ~ /^(ABI|ANT|ARN|ASI|ATL|BNG|BAN|BCA|BEI|BEN|BER|BGT|BRV|BUA|CAC|CAM|CHA|CHI|COM|CON|COV|DAK|DEL|DHA|FIR|FRE|FHN|GEN|GMC|GVD|HAL|HEL|HIR|JEU|JER|KAL|KTS|KIE|KOB|KOE|KTR|KRA|KRU|KMV|KYR|HDL|LEF|LHA|LAM|LAP|LPS|LIB|LIG|LIM|LIS|LJA|LOM|LUB|MDI|MAP|MRH|MZO|MEL|MSL|MXY|MIL|MKE|MIN|MOR|MOS|NAB|NAG|NED|NEH|ORE|OSW|PAU|POK|PTV|POR|PLP|PRA|PUE|QIO|RAV|RIJ|ROM|HRO|SCA|SFR|SJO|SPE|SAR|SHE|SLG|SOI|SPA|SPL|SRK|STO|SUW|TAS|TBL|TOK|TOR|TON|VAN|VER|VIS|VLA|VOL|WAR|WLN|WIE|WOL|WRO|YSO|YOK|ZGB|ZUR)$/)
  {
    printf("%s=%s\n", $call, $col);
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
