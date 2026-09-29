BEGIN {
  printf("#00 Arkansas QSO Party prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  call = 1;
  state = 2;
}
{
if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      ($state ~ /^(AL|AK|AZ|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/ || \
      $state ~ /^(ARK|ASH|BAX|BEN|BOO|BRA|CAL|CAR|CHI|CLA|CLE|CLK|CLV|COL|CON|CRA|CRG|CRI|CRO|DAL|DES|DRE|FAU|FRA|FUL|GAR|GNT|GRE|HEM|HOW|HSP|IND|IZA|JAK|JEF|JON|LAF|LAW|LEE|LIN|LOG|LON|LRV|MAD|MGY|MIL|MIS|MON|MRN|NEV|NEW|OUA|PER|PHI|PIK|PLK|POI|POP|PRA|PUL|RAN|SAL|SCO|SCY|SEB|SFR|SHA|STO|SVR|UNI|VBN|WAS|WHI|WOO|YEL)$/)) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]{1,3}|\/)|^V[EOY][0-9]\/|V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state != "")
  {
    # printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
