BEGIN {
  FS=","
  printf("#0 CQ Bande Basse Italia database\n");
  printf("#1 Based on data maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Sect/) sect = 2;
    if ($4 ~ /Sect/) sect = 3;
    if ($5 ~ /Sect/) sect = 4;
    if ($3 ~ /Misc/) misc = 2;
    if ($4 ~ /Misc/) misc = 3;
    if ($5 ~ /Misc/) misc = 4;
    printf("%s --> sect=%d, misc=%d\n", $0, sect, misc) > "/dev/stderr";
  } 
  else if ($1 ~ /^[A-Z0-9\/]{3,}$/ && $sect ~ /^(FR|LT|PG|RI|RM|TR|VT|AL|AT|BI|CN|GE|IM|NO|SP|SV|TO|VB|VC|BG|BS|CO|CR|LC|LO|MB|MI|MN|PV|SO|VA|BL|PD|RO|TV|VE|VI|VR|BO|FC|FE|MO|PC|PR|RA|RE|RN|AR|FI|GR|LI|LU|MS|PI|PO|PT|SI|AN|AP|AQ|CH|FM|MC|PE|PS|PU|TE|BA|BR|BT|FG|LE|MT|TA|AV|BN|CB|CE|CS|CZ|IS|KR|NA|PZ|RC|SA|VV|AG|CL|CT|EN|ME|PA|RG|SR|TP|CA|CI|NU|OG|OR|OT|SS|VS|AO|BZ|TN|GO|PN|TS|UD|GRI|RSM|SCV|SMM|TI)$/ && $misc ~ /^([0-9]+|)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s;%s\n", $1, $sect, $misc);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "") {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}