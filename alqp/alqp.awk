BEGIN {
  FS=","
  printf("#0 Alabama QSO Party database\n");
  printf("#1 Based on call history data maintained by VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($2 ~ /Exch1/) col = 1;
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else if (\
      ($1 ~ /^((A[A-L]|K[A-Z]?|N[A-Z]?|W[A-Z]?)[0-9])|\/W[0-9]$/ && $col ~ /^(AK|AR|AZ|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      ($1 ~ /^((A[A-L]|K[A-Z]?|N[A-Z]?|W[A-Z]?)[0-9])|\/W[0-9]$/ && $col ~ /^(AUTA|BALD|BARB|BIBB|BLOU|BULL|BUTL|CHOU|CHMB|CKEE|CHIL|CHOC|CLRK|CLAY|CLEB|COFF|COLB|CONE|COOS|COVI|CREN|CULM|DALE|DLLS|DKLB|ELMO|ESCA|ETOW|FAYE|FRNK|GENE|GREE|HALE|HNRY|HOUS|JKSN|JEFF|LAMA|LAUD|LAWR|LEE|LIME|LOWN|MACO|MDSN|MRGO|MARI|MRSH|MOBI|MNRO|MGMY|MORG|PERR|PICK|PIKE|RAND|RSSL|SCLR|SHEL|SUMT|TDEG|TPOO|TUSC|WLKR|WASH|WLCX|WINS)$/) || \
      ($1 ~ /^V[A-EOXY][0-9]/ && $col ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)) {
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
