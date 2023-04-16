BEGIN {
  FS=","
  printf("#0 Tennessee QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("\"%s\" --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TX|UT|VT|VA|WA|WV|WI|WY|AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT|ANDE|BEDF|BENT|BLED|BLOU|BRAD|CAMP|CANN|CARR|CART|CHEA|CHES|CLAI|CLAY|COCK|COFF|CROC|CUMB|DAVI|DECA|DEKA|DICK|DYER|FAYE|FENT|FRAN|GIBS|GILE|GRAI|GREE|GRUN|HAMB|HAMI|HANC|HARD|HARN|HAWK|HAYW|HEND|HENR|HICK|HOUS|HUMP|JACK|JEFF|JOHN|KNOX|LAKE|LAUD|LAWR|LEWI|LINC|LOUD|MACO|MADI|MARI|MARS|MAUR|MCMI|MCNA|MEIG|MONR|MONT|MOOR|MORG|OBIO|OVER|PERR|PICK|POLK|PUTN|RHEA|ROAN|ROBE|RUTH|SCOT|SEQU|SEVI|SHEL|SMIT|STEW|SULL|SUMN|TIPT|TROU|UNIC|UNIO|VANB|WARR|WASH|WAYN|WEAK|WHIT|WILL|WILS)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
