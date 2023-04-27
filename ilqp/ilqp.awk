BEGIN {
  printf("#0 Illinois QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($3 == "Exch1") col = 2;
    if ($4 == "Exch1") col = 3;
    if ($5 == "Exch1") col = 4;
    printf("\"%s\" --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/ && $col ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|NL|NB|NS|PE|QC|ON|MB|SK|AB|BC|NT|NU|YT|ADAM|ALEX|BOND|BOON|BROW|BURO|CALH|CARR|CASS|CHAM|CHRS|CLAY|CLNT|CLRK|COLE|COOK|CRAW|CUMB|DEKA|DEWT|DOUG|DUPG|EDGR|EDWA|EFFG|FAYE|FORD|FRNK|FULT|GALL|GREE|GRUN|HAML|HANC|HARD|HENR|HNDR|IROQ|JACK|JASP|JEFF|JERS|JODA|JOHN|KANE|KANK|KEND|KNOX|LAKE|LASA|LAWR|LEE|LIVG|LOGN|MACN|MADN|MARI|MASN|MCDN|MCHE|MCLN|MCPN|MNRD|MNRO|MNTG|MORG|MOUL|MRCR|MSHL|MSSC|OGLE|PEOR|PERR|PIAT|PIKE|POPE|PULA|PUTN|RAND|RICH|ROCK|SALI|SANG|SCHY|SCLA|SCOT|SHEL|STAR|STEP|TAZW|UNIO|VERM|WABA|WARR|WASH|WAYN|WBGO|WHIT|WILL|WMSN|WOOD|WTSD)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
    printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "") {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
