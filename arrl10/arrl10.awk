BEGIN {
  printf("#00 ARRL 10m database - state or province for US, Canadian, and Mexican stations\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /State/) col = 2;
    if ($4 ~ /State/) col = 3;
    if ($5 ~ /State/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  }
  else if (($1 ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3}(\/[0-9AMP])?)$|^(KL7|KH6|W[0-9])\/|\/(KL7|KH6|W[0-9])$/ && $col ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) \
    || ($1 ~ /^V[A-EOXY][0-9]([A-Z]{1,3}(\/[0-9AMP])?$|\/)|\/V[EOY][0-9]$/ && $col ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) \
    || ($1 ~ /^(XE|6D)[0-9][A-Z]{1,3}(\/(XE)?[0-9AMP])?$/ && $col ~ /^(AGS|BAC|BCS|CAM|CHI|CHH|CMX|COA|COL|DGO|EMX|GTO|GRO|HGO|JAL|MIC|MOR|NAY|NLE|OAX|PUE|QRO|QUI|SLP|SIN|SON|TAB|TAM|TLX|VER|YUC|ZAC)$/) )
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    } 
    else
    {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
