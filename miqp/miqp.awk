BEGIN {
  FS=","
  printf("#0 Michigan QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") 
  {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if (\
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|MD|MA|ME|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $col ~ /^(ALCO|ALGE|ALLE|ALPE|ANTR|AREN|BARA|BARR|BAY|BENZ|BERR|BRAN|CALH|CASS|CHAR|CHEB|CHIP|CLAR|CLIN|CRAW|DELT|DICK|EATO|EMME|GENE|GLAD|GOGE|GRAT|GRTR|HILL|HOUG|HURO|INGH|IONI|IOSC|IRON|ISAB|JACK|KALK|KENT|KEWE|KZOO|LAKE|LAPE|LEEL|LENA|LIVI|LUCE|MACK|MACO|MANI|MARQ|MASO|MCLM|MECO|MENO|MIDL|MISS|MONR|MTMO|MUSK|NEWA|OAKL|OCEA|OGEM|ONTO|OSCE|OSCO|OTSE|OTTA|PRES|ROSC|SAGI|SANI|SCHO|SHIA|STCL|STJO|TUSC|VANB|WASH|WAYN|WEXF)$/) || \
    ($1 ~ /^V[A-EOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
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