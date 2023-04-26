BEGIN {
  FS=","
  printf("#0 Illinois QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($2 == "Exch1") col = 1;
    if ($3 == "Exch1") col = 2;
    if ($4 == "Exch1") col = 3;
    if ($5 == "Exch1") col = 4;
    printf("\"%s\" --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } else {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      if ($1 ~ /^[0-9A-Z/]+$/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY|AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT|ADAM|ALEX|BOND|BOON|BROW|BURO|CALH|CARR|CASS|CHAM|CHRS|CLAY|CLNT|CLRK|COLE|COOK|CRAW|CUMB|DEKA|DEWT|DOUG|DUPG|EDGR|EDWA|EFFG|FAYE|FORD|FRNK|FULT|GALL|GREE|GRUN|HAML|HANC|HARD|HENR|HNDR|IROQ|JACK|JASP|JEFF|JERS|JODA|JOHN|KANE|KANK|KEND|KNOX|LAKE|LASA|LAWR|LEE|LIVG|LOGN|MACN|MADN|MARI|MASN|MCDN|MCHE|MCLN|MCPN|MNRD|MNRO|MNTG|MORG|MOUL|MRCR|MSHL|MSSC|OGLE|PEOR|PERR|PIAT|PIKE|POPE|PULA|PUTN|RAND|RICH|ROCK|SALI|SANG|SCHY|SCLA|SCOT|SHEL|STAR|STEP|TAZW|UNIO|VERM|WABA|WARR|WASH|WAYN|WBGO|WHIT|WILL|WMSN|WOOD|WTSD)$/) {
        printf("%s=%s\n", $1, $col);
        lines[$1] = $0;
      }
      else if ($0 !~ /^(!|#|$)/ && $col != "")
        printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
