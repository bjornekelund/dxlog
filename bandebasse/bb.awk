BEGIN {
  printf("#00 CQ Bande Basse Italia prefill database\n");
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
    if ($3 ~ /Sect/) sect = 2;
    if ($4 ~ /Sect/) sect = 3;
    if ($5 ~ /Sect/) sect = 4;
    if ($3 ~ /Misc/) memb = 2;
    if ($4 ~ /Misc/) memb = 3;
    if ($5 ~ /Misc/) memb = 4;
    printf("%s --> call=%d sect=%d, memb=%d\n", $0, call, sect, memb) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^(I[A-Z]?[0-9]\/)?I[A-Z]?[0-9]{1}[A-Z]{1,3}(\/(QRP|[P0-9]|I[A-Z]?[0-9]))?$/ && \
    $sect ~ /^(FR|LT|PG|RI|RM|TR|VT|AL|AT|BI|CN|GE|IM|NO|SP|SV|TO|VB|VC|BG|BS|CO|CR|LC|LO|MB|MI|MN|PV|SO|VA|BL|PD|RO|TV|VE|VI|VR|BO|FC|FE|MO|PC|PR|RA|RE|RN|AR|FI|GR|LI|LU|MS|PI|PO|PT|SI|AN|AP|AQ|CH|FM|MC|PE|PU|TE|BA|BR|BT|FG|LE|MT|TA|AV|BN|CB|CE|CS|CZ|IS|KR|NA|PZ|RC|SA|VV|BZ|TN|CA|NU|OG|OR|OT|SS|SU|VS|AG|CL|CT|EN|ME|PA|RG|SR|TP|GO|PN|TS|UD|AO|GRI|RSM|SCV|SMM|TI)$/ && \
    $memb ~ /^([1-9][0-9]{,3}|)$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s;%s\n", $call, $sect, $memb);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}