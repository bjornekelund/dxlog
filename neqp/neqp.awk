BEGIN {
  FS=","
  printf("#00 Nevada QSO Party database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
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
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/[0-9MP])?$|\/)|\/(W[0-9]|KL7|KH6)$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/[0-9MP])?$|\/)|\/(W[0-9]|KL7|KH6)$/ && $state ~ /^(ADMS|ANTE|ARTH|BANN|BLAI|BOON|BOXB|BOYD|BRWN|BUFF|BURT|BUTL|CASS|CEDA|CHAS|CHER|CHEY|CLAY|COLF|CUMI|CUST|DAKO|DAWE|DAWS|DEUE|DIXO|DODG|DGLS|DUND|FILL|FRNK|FRON|FURN|GAGE|GARD|GARF|GOSP|GRAN|GREE|HALL|HAMI|HRLN|HAYE|HITC|HOLT|HOOK|HOWA|JEFF|JOHN|KEAR|KEIT|KEYA|KIMB|KNOX|LNCS|LINC|LOGA|LOUP|MDSN|MCPH|MERR|MORR|NANC|NEMA|NUCK|OTOE|PAWN|PERK|PHEL|PIER|PLAT|POLK|REDW|RICH|ROCK|SALI|SARP|SAUN|SCOT|SEWA|SHRD|SHRM|SIOU|STAN|THAY|THOM|THUR|VLLY|WASH|WAYN|WEBS|WHEE|YORK)$/) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
