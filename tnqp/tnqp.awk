BEGIN {
  FS=","
  printf("#0 Tennessee QSO Party database\n");
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
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(ANDE|BEDF|BENT|BLED|BLOU|BRAD|CAMP|CANN|CARR|CART|CHEA|CHES|CLAI|CLAY|COCK|COFF|CROC|CUMB|DAVI|DECA|DEKA|DICK|DYER|FAYE|FENT|FRAN|GIBS|GILE|GRAI|GREE|GRUN|HAMB|HAMI|HANC|HARD|HARN|HAWK|HAYW|HEND|HENR|HICK|HOUS|HUMP|JACK|JEFF|JOHN|KNOX|LAKE|LAUD|LAWR|LEWI|LINC|LOUD|MACO|MADI|MARI|MARS|MAUR|MCMI|MCNA|MEIG|MONR|MONT|MOOR|MORG|OBIO|OVER|PERR|PICK|POLK|PUTN|RHEA|ROAN|ROBE|RUTH|SCOT|SEQU|SEVI|SHEL|SMIT|STEW|SULL|SUMN|TIPT|TROU|UNIC|UNIO|VANB|WARR|WASH|WAYN|WEAK|WHIT|WILL|WILS)$/) || \
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
  else if ($0 !~ /^(!|#|$)/ && $state !~ /^$/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
