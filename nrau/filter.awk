BEGIN {
  printf("#00 NRAU Baltic Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Sect|Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
    $exch ~ /^(HM|HR|IV|JG|JR|LN|LV|PL|PU|RP|SR|TA|TL|VC|VO|VP|AG|AK|BO|BU|FI|HO|IN|JA|MO|NO|OF|OS|RL|SV|TE|TR|XX|AT|KD|KI|KM|KN|MM|PA|PN|SI|SU|TG|TI|UT|VU|VV|AL|EK|EP|ES|KE|KL|KP|KT|KU|LA|PH|PK|PM|PO|PP|PS|SA|UU|VA|BH|KH|NJ|SJ|VJ|VS|FA|GR|BL|DA|GA|GO|HA|JL|JO|KA|KR|NB|OG|OR|SE|SL|SO|UP|VB|VD|VL|VM|VN|IS|AI|AU|BA|BV|CE|DG|DO|GU|JE|JP|KG|KV|LI|LM|LU|MD|OE|PR|RE|RR|SD|TS|TU|VE|VK|VR)$/ )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $exch);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $exch != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
