BEGIN {
  FS=","
  printf("#0 British Columbia QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else if (\
      ($1 ~ /^((A[A-L]|K[A-Z]?|N[A-Z]?|W[A-Z]?)[0-9])|\/W[0-9]$/ && $col ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
      ($1 ~ /^V[A-EOXY][0-9]|\/VE[0-9]$/ && $col ~ /^(NS|QC|ON|MB|SK|AB|NT|NB|NL|NU|YT|PE)$/) ||\
      ($1 ~ /^V[A-EOXY][0-9]|\/VE[0-9]$/ && $col ~ /^(ASL|BNS|BUC|CHP|CKS|CLC|CML|COA|CPC|CPG|DEL|ESQ|FPK|KEL|KSC|KTN|LTF|MMA|NAL|NBM|NPR|NVC|OSK|PMC|PMM|PPN|RCM|RES|SBV|SGI|SSW|SUC|SUN|SWR|VAC|VAE|VAG|VAK|VAQ|VIC|VLM|VSB|WVS)$/)) 
  {
    if ($col == "DC") $col = "MD";
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($1 ~ /^(A[A-L]|K|N|W|C[F-K]|V[A-G]VX|VY9|X[LM]|C[F-Z]|V[A-Y]|X[J-O])/ && $col !~ /^$/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";  
  }
}

