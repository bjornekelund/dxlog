BEGIN {
  FS=","
  printf("#0 Louisiana QSO Party database\n");
  printf("#1 Based on NAQP database maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|ACAD|ALLE|ASCE|ASSU|AVOY|BEAU|BIEN|BOSS|CADD|CALC|CALD|CAME|CATA|CLAI|CONC|DESO|EBR|ECAR|EFEL|EVAN|FRAN|GRAN|IBER|IBVL|JACK|JEFF|JFDV|LAFA|LAFO|LASA|LINC|LIVI|MADI|MORE|NATC|ORLE|OUAC|PCP|PLAQ|RAPI|REDR|RICH|SABI|SBND|SCHL|SHEL|SJAM|SJB|SLAN|SMAR|SMT|STAM|TANG|TENS|TERR|UNIO|VERM|VERN|WASH|WBR|WCAR|WEBS|WFEL|WINN)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", toupper($1), toupper($col));
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "") {
    printf("Ignored: %s\n", $0) > "/dev/stderr";
  }
}