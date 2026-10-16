BEGIN {
  printf("#00 South Carolina QSO Party prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    state = FindColumn("State|Exch1");
  # printf\("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ( \
    (IsUScall($call) && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(ABBE|AIKE|ALLE|ANDE|BAMB|BARN|BEAU|BERK|CHOU|CHAR|CHES|CHFD|CKEE|CLRN|COLL|DARL|DILL|DORC|EDGE|FAIR|FLOR|GEOR|GRWD|GVIL|HAMP|HORR|JASP|KERS|LAUR|LEE|LEXI|LNCS|MARI|MARL|MCOR|NEWB|OCON|ORNG|PICK|RICH|SALU|SPAR|SUMT|UNIO|WILL|YORK)(\/(ABBE|AIKE|ALLE|ANDE|BAMB|BARN|BEAU|BERK|CHOU|CHAR|CHES|CHFD|CKEE|CLRN|COLL|DARL|DILL|DORC|EDGE|FAIR|FLOR|GEOR|GRWD|GVIL|HAMP|HORR|JASP|KERS|LAUR|LEE|LEXI|LNCS|MARI|MARL|MCOR|NEWB|OCON|ORNG|PICK|RICH|SALU|SPAR|SUMT|UNIO|WILL|YORK))?$/)) || \
    (IsVEcall($call) && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableVE13($call, $state))
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call) && $state != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
