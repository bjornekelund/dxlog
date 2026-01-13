BEGIN {
  printf("#00 South Carolina QSO Party prefill database\n");
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
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  } 
  else if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(ABBE|AIKE|ALLE|ANDE|BAMB|BARN|BEAU|BERK|CHOU|CHAR|CHES|CHFD|CKEE|CLRN|COLL|DARL|DILL|DORC|EDGE|FAIR|FLOR|GEOR|GRWD|GVIL|HAMP|HORR|JASP|KERS|LAUR|LEE|LEXI|LNCS|MARI|MARL|MCOR|NEWB|OCON|ORNG|PICK|RICH|SALU|SPAR|SUMT|UNIO|WILL|YORK)$/)) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]{1,3}(\/[MP])?$|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $call, $3);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $3 != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}