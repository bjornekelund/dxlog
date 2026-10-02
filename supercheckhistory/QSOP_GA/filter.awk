BEGIN {
  printf("#00 Georgia QSO Party prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  call = 1;
  state = 2;
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($2 ~ /Exch1/) state = 1;
    if ($3 ~ /Exch1/) state = 2;
    if ($4 ~ /Exch1/) state = 3;
    if ($5 ~ /Exch1/) state = 4;
  # printf\("%s --> call=&d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if (\
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/([0-9MP]|QRP))?$|\/)|\/(W[0-9]|KL7|KH6)$/ && \
      ($state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/ || \
      $state ~ /^(APPL|ATKN|BACN|BAKR|BALD|BANK|BARR|BART|BENH|BERR|BIBB|BLEC|BRAN|BROK|BRYN|BULL|BURK|BUTT|CALH|CMDN|CAND|CARR|CATO|CHAR|CHTM|CHAT|CHGA|CHER|CLKE|CLAY|CLTN|CLCH|COBB|COFF|COLQ|COLU|COOK|COWE|CRAW|CRIS|DADE|DAWS|DECA|DKLB|DODG|DOOL|DHTY|DOUG|EARL|ECHO|EFFI|ELBE|EMAN|EVAN|FANN|FAYE|FLOY|FORS|FRAN|FULT|GILM|GLAS|GLYN|GORD|GRAD|GREE|GWIN|HABE|HALL|HANC|HARA|HARR|HART|HEAR|HNRY|HOUS|IRWI|JACK|JASP|JFDA|JEFF|JENK|JOHN|JONE|LAMA|LANI|LAUR|LEE|LIBE|LINC|LONG|LOWN|LUMP|MCDU|MCIN|MACO|MADI|MARI|MERI|MILL|MITC|MNRO|MONT|MORG|MURR|MUSC|NEWT|OCON|OGLE|PAUL|PEAC|PICK|PIER|PIKE|POLK|PULA|PUTN|QUIT|RABU|RAND|RICH|ROCK|SCHL|SCRE|SEMI|SPAL|STEP|STWT|SUMT|TLBT|TALI|TATT|TAYL|TELF|TERR|THOM|TIFT|TOOM|TOWN|TREU|TROU|TURN|TWIG|UNIO|UPSO|WLKR|WALT|WARE|WARR|WASH|WAYN|WEBS|WHEE|WHIT|WFLD|WCOX|WILK|WKSN|WORT)$/)) || \
    ($call ~ /^V[A-EOY][0-9]|\/V[EOY][0-9]$/ && $state ~ /^(QC|ON|MB|SK|AB|BC|NB|NL|NS|PE|NT|NU|YT)$/))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (notpredictableve13($call, $state))
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

