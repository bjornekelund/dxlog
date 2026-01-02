BEGIN {
  FS=","
  printf("#0 Database for Atlantic Canada QSO Party\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if (\
      ($1 ~ /^((A[A-L]|K[A-Z]?|N[A-Z]?|W[A-Z]?)[0-9][A-Z]+)|\/W[0-9]$/ && $col ~ /^(AL|AK|AR|AZ|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      ($1 ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(QC|ON|MB|SK|AB|BC|NT|NU|YT)$/) ||\
      ($1 ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(NLASJ|NLBMT|NLSCB|NLSGS|NLHCB|NLGFW|NLBTC|NLNDL|NLNSA|NLLGB|NLLNN|PEKGS|PEQNS|PEPRN|NBALB|NBCAR|NBCHA|NBGLO|NBKEN|NBKGS|NBMAD|NBNOR|NBQNS|NBRES|NBSJC|NBSUN|NBVIC|NBWES|NBYOR|NSANP|NSATG|NSCBR|NSCOL|NSCMB|NSDIG|NSGUY|NSHRM|NSHNT|NSINV|NSKGS|NSLUN|NSPIC|NSQNS|NSRIC|NSSHL|NSVIC|NSYAR)$/)) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(QC|ON|MB|SK|AB|BC|NT|NU|YT)$/)
    {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
