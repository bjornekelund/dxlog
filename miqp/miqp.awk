BEGIN {
  FS=","
  printf("#0 Michigan QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $col ~ /^(AB|AK|AL|AR|AZ|BC|CA|CO|CT|DE|DX|FL|GA|HI|IA|ID|IL|IN|KS|KY|LA|MA|MB|MD|ME|MN|MO|MS|MT|NB|NC|ND|NE|NH|NJ|NL|NM|NS|NT|NU|NV|NY|OH|OK|ON|OR|PA|PE|QC|RI|SC|SD|SK|TN|TX|UT|VA|VT|WA|WI|WV|WY|YT|ALCO|ALGE|ALLE|ALPE|ANTR|AREN|BARA|BARR|BAY|BENZ|BERR|BRAN|CALH|CASS|CHAR|CHEB|CHIP|CLAR|CLIN|CRAW|DELT|DICK|EATO|EMME|GENE|GLAD|GOGE|GRAT|GRTR|HILL|HOUG|HURO|INGH|IONI|IOSC|IRON|ISAB|JACK|KALK|KENT|KEWE|KZOO|LAKE|LAPE|LEEL|LENA|LIVI|LUCE|MACK|MACO|MANI|MARQ|MASO|MCLM|MECO|MENO|MIDL|MISS|MONR|MTMO|MUSK|NEWA|OAKL|OCEA|OGEM|ONTO|OSCE|OSCO|OTSE|OTTA|PRES|ROSC|SAGI|SANI|SCHO|SHIA|STCL|STJO|TUSC|VANB|WASH|WAYN|WEXF)$/) {
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