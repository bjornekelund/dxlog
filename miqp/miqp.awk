BEGIN {
  FS=","
  printf("#00 Michigan QSO Party database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
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
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  } 
  else if (\
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/[0-9MP])?$|\/)|\/(W[0-9]|KL7|KH6)$/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|DC|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|MD|MA|ME|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/[0-9MP])?$|\/)|\/(W[0-9]|KL7|KH6)$/ && $col ~ /^(ALCO|ALGE|ALLE|ALPE|ANTR|AREN|BARA|BARR|BAY|BENZ|BERR|BRAN|CALH|CASS|CHAR|CHEB|CHIP|CLAR|CLIN|CRAW|DELT|DICK|EATO|EMME|GENE|GLAD|GOGE|GRAT|GRTR|HILL|HOUG|HURO|INGH|IONI|IOSC|IRON|ISAB|JACK|KALK|KENT|KEWE|KZOO|LAKE|LAPE|LEEL|LENA|LIVI|LUCE|MACK|MACO|MANI|MARQ|MASO|MCLM|MECO|MENO|MIDL|MISS|MONR|MTMO|MUSK|NEWA|OAKL|OCEA|OGEM|ONTO|OSCE|OSCO|OTSE|OTTA|PRES|ROSC|SAGI|SANI|SCHO|SHIA|STCL|STJO|TUSC|VANB|WASH|WAYN|WEXF)$/) || \
    ($call ~ /^V[A-GOXY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $call, $col);
      lines[$call] = $0;
    }
  } 
  else if ($0 !~ /^(!|#|$)/ && $col != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}