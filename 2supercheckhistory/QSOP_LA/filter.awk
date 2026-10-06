BEGIN {
  printf("#00 Louisiana QSO Party prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) state = 2;
    if ($4 ~ /Exch1/) state = 3;
    if ($5 ~ /Exch1/) state = 4;
  # printf\("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ( \
    (IsUScall($call) && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(ACAD|ALLE|ASCE|ASSU|AVOY|BEAU|BIEN|BOSS|CADD|CALC|CALD|CAME|CATA|CLAI|CONC|DESO|EBR|ECAR|EFEL|EVAN|FRAN|GRAN|IBER|IBVL|JACK|JEFF|JFDV|LAFA|LAFO|LASA|LINC|LIVI|MADI|MORE|NATC|ORLE|OUAC|PCP|PLAQ|RAPI|REDR|RICH|SABI|SBND|SCHL|SHEL|SJAM|SJB|SLAN|SMAR|SMT|STAM|TANG|TENS|TERR|UNIO|VERM|VERN|WASH|WBR|WCAR|WEBS|WFEL|WINN)$/)) || \
    (IsVEcall($call) && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableVE13($call, $state))
    {
      printf("%s=%s\n", toupper($call), toupper($state));
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && IsNAcall($call))
  {
    printf("Ignored: \"%s\" invalid exchange\n", $0) > "/dev/stderr";
  }
}
