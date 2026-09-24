BEGIN {
  printf("#00 Alabama QSO Party prefill database\n");
  printf("#01 Based on data maintained by VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
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
    # printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      ($state ~ /^(AK|AR|AZ|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/ || \
      $state ~ /^(AUTA|BALD|BARB|BIBB|BLOU|BULL|BUTL|CHOU|CHMB|CKEE|CHIL|CHOC|CLRK|CLAY|CLEB|COFF|COLB|CONE|COOS|COVI|CREN|CULM|DALE|DLLS|DKLB|ELMO|ESCA|ETOW|FAYE|FRNK|GENE|GREE|HALE|HNRY|HOUS|JKSN|JEFF|LAMA|LAUD|LAWR|LEE|LIME|LOWN|MACO|MDSN|MRGO|MARI|MRSH|MOBI|MNRO|MGMY|MORG|PERR|PICK|PIKE|RAND|RSSL|SCLR|SHEL|SUMT|TDEG|TPOO|TUSC|WLKR|WASH|WLCX|WINS)$/)) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]{1,3}(\/[0-9MP])?$|\/)|^V[EOY][0-9]\/|V[EOY][0-9]$/ && $state ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
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
