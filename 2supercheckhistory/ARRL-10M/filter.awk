BEGIN {
  printf("#00 ARRL 10m Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /State|Exch1/) state = 2;
    if ($4 ~ /State|Exch1/) state = 3;
    if ($5 ~ /State|Exch1/) state = 4;
    # printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if (($call ~ /^((A[A-L]|[KNW][A-Z]?)[0-9][A-Z]{1,3}(\/[0-9AMP])?)$|^(KL7|KH6|W[0-9])\/|\/(KL7|KH6|W[0-9])$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) \
    || ($call ~ /^V[A-GOXY][0-9]([A-Z]{1,3}(\/[0-9AMP])?$|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NF|NS|NT|NU|ON|PE|QC|SK|YT)$/) \
    || ($call ~ /^(XE|6D)[0-9][A-Z]{1,3}(\/(XE)?[0-9AMP])?$/ && $state ~ /^(AGS|BAC|BCS|CAM|CHI|CHH|CMX|COA|COL|DGO|EMX|GTO|GRO|HGO|JAL|MIC|MOR|NAY|NLE|OAX|PUE|QRO|QUI|SLP|SIN|SON|TAB|TAM|TLX|VER|YUC|ZAC)$/) )
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if (NotPredictableVE14($call, $state))
    {
      printf("%s=%s\n", $call, $state);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
