BEGIN {
  FS=",";
  printf("#0 California QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 1;
}
{
  if ($0 ~ /!!Order!!/) {
    if ($3 ~ /EXCH1/Exch1) col = 2;
    if ($4 ~ /EXCH1|Exch1/) col = 3;
    if ($5 ~ /EXCH1|Exch1/) col = 4;
    printf("%s --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } else {
    gsub(/ /, "", $col);
    exch = $col;
    if ($col == "DC") {
      printf("Bad exchange: \"%s\" should be MD\n", $0) > "/dev/stderr";
      exch = "MD";
    }
    if (\
       ($1 ~ /^((A[A-L]|[KNW][A-Z]?)[0-9])([A-Z]+|\/)|W[0-9]$/ && exch ~ /^(AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
       ($1 ~ /^((A[A-L]|[KNW][A-Z]?)[0-9])([A-Z]+|\/)|W[0-9]$/ && exch ~ /^(ALAM|ALPI|AMAD|BUTT|CALA|COLU|CCOS|DELN|ELDO|FRES|GLEN|HUMB|IMPE|INYO|KERN|KING|LAKE|LASS|LANG|MADE|MARN|MARP|MEND|MERC|MODO|MONO|MONT|NAPA|NEVA|ORAN|PLAC|PLUM|RIVE|SACR|SBEN|SBER|SDIE|SFRA|SJOA|SLUI|SMAT|SBAR|SCLA|SCRU|SHAS|SIER|SISK|SOLA|SONO|STAN|SUTT|TEHA|TRIN|TULA|TUOL|VENT|YOLO|YUBA)(\/(ALAM|ALPI|AMAD|BUTT|CALA|COLU|CCOS|DELN|ELDO|FRES|GLEN|HUMB|IMPE|INYO|KERN|KING|LAKE|LASS|LANG|MADE|MARN|MARP|MEND|MERC|MODO|MONO|MONT|NAPA|NEVA|ORAN|PLAC|PLUM|RIVE|SACR|SBEN|SBER|SDIE|SFRA|SJOA|SLUI|SMAT|SBAR|SCLA|SCRU|SHAS|SIER|SISK|SOLA|SONO|STAN|SUTT|TEHA|TRIN|TULA|TUOL|VENT|YOLO|YUBA)){0,2}$/) || \
       ($1 ~ /^V[A-EOXY][0-9]([A-Z]+|\/)|\/VE[0-9]$/ && exch ~ /^(AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT)$/))
    {
      if (lines[$1] != "") 
      {
        printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
      }
      else if (exch !~ /^(AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT)$/)
      {
        printf("%s=%s\n", $1, exch);
        lines[$1] = $0;
      }
    }
    else if ($col !~ /^(!|#|$)/) 
    {
      printf("Bad exchange: \"%s\" should be DX\n", $0) > "/dev/stderr";
    }
  }
}
