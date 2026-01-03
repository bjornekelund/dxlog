BEGIN {
  FS=","
  printf("#00 British Columbia QSO Party database\n");
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
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  } 
  else if ( \
    ($call ~ /^((A[A-L]|K[A-Z]?|N[A-Z]?|W[A-Z]?)[0-9]([A-Z]+|\/))|\/W[0-9]$/ && $col ~ /^(AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MO|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY)$/) || \
    ($call ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(NS|QC|ON|MB|SK|AB|NT|NB|NL|NU|YT|PE)$/) ||\
    ($call ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $col ~ /^(ASL|BNS|BUC|CHP|CKS|CLC|CML|COA|CPC|CPG|DEL|ESQ|FPK|KEL|KSC|KTN|LTF|MMA|NAL|NBM|NPR|NVC|OSK|PMC|PMM|PPN|RCM|RES|SBV|SGI|SSW|SUC|SUN|SWR|VAC|VAE|VAG|VAK|VAQ|VIC|VLM|VSB|WVS)$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(NS|QC|ON|MB|SK|AB|NT|NB|NL|NU|YT|PE)$/)
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

#   else if ($call ~ /^(A[A-L]|K|N|W|C[F-K]|V[A-G]VX|VY9|X[LM]|C[F-Z]|V[A-Y]|X[J-O])/ && $col !~ /^$/) 
