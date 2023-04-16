BEGIN {
  FS=","
  printf("#0 Nevada QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 3;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|QC|ON|MB|SK|AB|BC|NB|NL|NS|PE|NT|NU|YT|ADMS|ANTE|ARTH|BANN|BLAI|BOON|BOXB|BOYD|BRWN|BUFF|BURT|BUTL|CASS|CEDA|CHAS|CHER|CHEY|CLAY|COLF|CUMI|CUST|DAKO|DAWE|DAWS|DEUE|DIXO|DODG|DGLS|DUND|FILL|FRNK|FRON|FURN|GAGE|GARD|GARF|GOSP|GRAN|GREE|HALL|HAMI|HRLN|HAYE|HITC|HOLT|HOOK|HOWA|JEFF|JOHN|KEAR|KEIT|KEYA|KIMB|KNOX|LNCS|LINC|LOGA|LOUP|MDSN|MCPH|MERR|MORR|NANC|NEMA|NUCK|OTOE|PAWN|PERK|PHEL|PIER|PLAT|POLK|REDW|RICH|ROCK|SALI|SARP|SAUN|SCOT|SEWA|SHRD|SHRM|SIOU|STAN|THAY|THOM|THUR|VLLY|WASH|WAYN|WEBS|WHEE|YORK)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
