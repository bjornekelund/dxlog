BEGIN {
  printf("#00 ARI DX prefill database\n");
  printf("#01 Based on data maintained by VE2FK\n");
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
    if ($3 ~ /Sect|Exch1/) state = 2;
    if ($4 ~ /Sect|Exch1/) state = 3;
    if ($5 ~ /Sect|Exch1/) state = 4;
    # printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ($call ~ /^I[A-Z]?[0-9]([A-Z]{1,3}(\/[0-9])?|\/.+)$/ && $state ~ /^(AL|AT|BI|CN|GE|IM|NO|SP|SV|TO|VB|VC|AO|BG|BS|CO|CR|LC|LO|MB|MI|MN|PV|SO|VA|BL|PD|RO|TV|VE|VI|VR|BZ|TN|GO|PN|TS|UD|BO|FC|FE|MO|PC|PR|RA|RE|RN|AR|FI|GR|LI|LU|MS|PI|PO|PT|SI|AN|AP|AQ|CH|FM|MC|PE|PU|TE|BA|BR|BT|FG|LE|MT|TA|AV|BN|CB|CE|CS|CZ|IS|KR|NA|PZ|RC|SA|VV|FR|LT|PG|RI|RM|TR|VT|AG|CL|CT|EN|ME|PA|RG|SR|TP|CA|NU|OR|SS|SU)$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
