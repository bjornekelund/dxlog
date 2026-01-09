BEGIN {
  FS=",";
  printf("#00 California QSO Party database\n");
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
    if ($3 ~ /State|Exch1/) col = 2;
    if ($4 ~ /State|Exch1/) col = 3;
    if ($5 ~ /State|Exch1/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else if ( \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/[0-9MP])?$|\/)|\/(W[0-9]|KL7|KH6)$|^4U1WB$/ && $col ~ /^(AL|AK|AZ|AR|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY)$/) || \
    ($call ~ /^(A[A-L]|[KNW][A-Z]?)[0-9](([A-Z]{1,3})(\/[0-9MP])?$|\/)|\/(W[0-9]|KL7|KH6)$|^4U1WB$/ && $col ~ /^(ALAM|ALPI|AMAD|BUTT|CALA|COLU|CCOS|DELN|ELDO|FRES|GLEN|HUMB|IMPE|INYO|KERN|KING|LAKE|LASS|LANG|MADE|MARN|MARP|MEND|MERC|MODO|MONO|MONT|NAPA|NEVA|ORAN|PLAC|PLUM|RIVE|SACR|SBEN|SBER|SDIE|SFRA|SJOA|SLUI|SMAT|SBAR|SCLA|SCRU|SHAS|SIER|SISK|SOLA|SONO|STAN|SUTT|TEHA|TRIN|TULA|TUOL|VENT|YOLO|YUBA)(\/(ALAM|ALPI|AMAD|BUTT|CALA|COLU|CCOS|DELN|ELDO|FRES|GLEN|HUMB|IMPE|INYO|KERN|KING|LAKE|LASS|LANG|MADE|MARN|MARP|MEND|MERC|MODO|MONO|MONT|NAPA|NEVA|ORAN|PLAC|PLUM|RIVE|SACR|SBEN|SBER|SDIE|SFRA|SJOA|SLUI|SMAT|SBAR|SCLA|SCRU|SHAS|SIER|SISK|SOLA|SONO|STAN|SUTT|TEHA|TRIN|TULA|TUOL|VENT|YOLO|YUBA)){0,2}$/) || \
    ($call ~ /^(V[A-GOXY]|C[F-KY]|X[J-M])[0-9](([A-Z]{1,3})(\/[1-9PM])?$|\/)|\/V[EOY][0-9]$/ && $col ~ /^(AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT)$/) )
  {
    if (lines[$call] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($col !~ /^(AB|BC|MB|NB|NL|NT|NS|NU|ON|PE|QC|SK|YT)$/)
    {
      printf("%s=%s\n", $call, $col);
      lines[$call] = $0;
    }
  }
  else if ($col !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\" should be DX\n", $0) > "/dev/stderr";
  }
}
