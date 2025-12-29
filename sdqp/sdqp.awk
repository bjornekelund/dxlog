BEGIN {
  FS=","
  printf("#0 South Dakota QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  state = 2;
}
{
  if ($0 ~ /!!Order!!/)
  {
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } 
  else if (\
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(AURO|BEAD|BENN|BONH|BROO|BRUL|BRWN|BUFF|BUTT|CAMP|CHAR|CLAY|CLRK|CODI|CORS|CUST|DAVI|DAY|DEUE|DEWY|DGLS|EDMU|FALL|FAUL|GRAN|GREG|HAAK|HAML|HAND|HNSN|HRDG|HUGH|HUTC|HYDE|JERA|JKSN|JONE|KING|LAKE|LAWR|LINC|LYMA|MCOO|MCPH|MEAD|MELL|MINE|MINN|MOOD|MRSH|OGLA|PENN|PERK|POTT|ROBE|SANB|SPIN|STAN|SULL|TODD|TRIP|TURN|UNIO|WALW|YANK|ZIEB)$/) || \
    ($1 ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $1, $state);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
