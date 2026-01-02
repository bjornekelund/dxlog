BEGIN {
  FS=","
  printf("#0 Database for UKEI DX Contest\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if ( \
    $1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ &&\
    $col ~ /^(AB|AL|AN|AR|BA|BB|BD|BH|BL|BM|BN|BR|BS|CA|CB|CE|CF|CH|CK|CL|CM|CN|CO|CR|CT|CV|CW|DA|DD|DE|DG|DH|DL|DN|DO|DR|DT|DU|DW|DY|EC|EH|EL|EN|EX|FE|FK|FY|GA|GL|GS|GU|GY|HA|HD|HG|HP|HR|HS|HU|HX|IG|IM|IP|IV|JE|KA|KD|KE|KI|KT|KW|KY|LA|LD|LE|LF|LH|LI|LL|LN|LO|LP|LS|LT|LU|MA|ME|MK|ML|MO|MR|MT|NE|NG|NK|NL|NN|NP|NW|OF|OL|OX|PA|PE|PH|PL|PO|PR|RG|RH|RM|RO|SA|SD|SE|SG|SI|SK|SL|SM|SN|SO|SP|SR|SS|ST|SW|SY|TA|TD|TF|TI|TN|TQ|TR|TS|TW|TY|UB|WA|WC|WD|WF|WI|WL|WM|WN|WR|WS|WT|WV|WX|YO|ZE)$/) 
  {
    if (lines[$1] != "" ) 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $2 != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}

