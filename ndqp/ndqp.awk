BEGIN {
  FS=","
  printf("#0 North Dakota QSO Party database\n");
  printf("#1 Based on NAQP database maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  state = 2;
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Exch1|State/) state = 2;
    if ($4 ~ /Exch1|State/) state = 3;
    if ($5 ~ /Exch1|State/) state = 4;
    printf("%s --> state=%d\n", $0, state) > "/dev/stderr";
  } 
  else if ( \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($1 ~ /^(A[A-L]|[KNW][A-Z]?)[0-9]([A-Z]+|\/)|\/W[0-9]$/ && $state ~ /^(ADM|BLL|BOT|BOW|BRK|BRN|BSN|BUR|CAV|CSS|DIK|DIV|DUN|EDY|EMN|FOS|GFK|GNT|GNV|GRG|HET|KDR|LMR|LOG|MCH|MCI|MCK|MCL|MCR|MRL|MTN|NEL|OLR|PBA|PRC|REN|RLD|RMY|ROL|RSM|SGT|SIX|SLP|SRN|STK|STL|STN|TRL|TWR|WLH|WLM|WLS|WRD)$/) || \
    ($1 ~ /^V[A-EOY][0-9]([A-Z]+|\/)|\/V[EOY][0-9]$/ && $state ~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($state !~ /^(AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", toupper($1), toupper($state));
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $state != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
