BEGIN {
  FS=","
  printf("#00 NRAU Baltic Contest database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Sect/) col = 2;
    if ($4 ~ /Sect/) col = 3;
    if ($5 ~ /Sect/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  } 
  else if ( \
    $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $col ~ /^(HM|HR|IV|JG|JR|LN|LV|PL|PU|RP|SR|TA|TL|VC|VO|VP|AG|AK|BO|BU|FI|HO|IN|JA|MO|NO|OF|OS|RL|SV|TE|TR|XX|AT|KD|KI|KM|KN|MM|PA|PN|SI|SU|TG|TI|UT|VU|VV|AL|EK|EP|ES|KE|KL|KP|KT|KU|LA|PH|PK|PM|PO|PP|PS|SA|UU|VA|BH|KH|NJ|SJ|VJ|VS|FA|GR|BL|DA|GA|GO|HA|JL|JO|KA|KR|NB|OG|OR|SE|SL|SO|UP|VB|VD|VL|VM|VN|IS|AI|AU|BA|BV|CE|DG|DO|GU|JE|JP|KG|KV|LI|LM|LU|MD|OE|PR|RE|RR|SD|TS|TU|VE|VK|VR)$/ )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else 
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
