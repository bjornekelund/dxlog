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
    if ($2 ~ /EXCH1|Exch1/) col = 1;
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
    if ($col ~ /^(NB|NL|NS|PE)$/){
      printf("Bad exchange: \"%s\" should be MR\n", $0) > "/dev/stderr";
      exch = "MR";
    }
    if ($col ~ /^(NU|YT)$/) {
      printf("Bad exchange: \"%s\" should be NT\n", $0) > "/dev/stderr";
      exch = "NT";
    }
    if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY])/ && exch ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|MR|QC|ON|MB|SK|AB|BC|NT|ALAM|ALPI|AMAD|BUTT|CALA|COLU|CCOS|DELN|ELDO|FRES|GLEN|HUMB|IMPE|INYO|KERN|KING|LAKE|LASS|LANG|MADE|MARN|MARP|MEND|MERC|MODO|MONO|MONT|NAPA|NEVA|ORAN|PLAC|PLUM|RIVE|SACR|SBEN|SBER|SDIE|SFRA|SJOA|SLUI|SMAT|SBAR|SCLA|SCRU|SHAS|SIER|SISK|SOLA|SONO|STAN|SUTT|TEHA|TRIN|TULA|TUOL|VENT|YOLO|YUBA)(\/[A-Z]{4})?$/) {
      if (lines[$1] != "") {
        printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
      }
      else {
        printf("%s=%s\n", $1, exch);
        lines[$1] = $0;
      }
    }
    else if ($col !~ /^(!|#|$)/) {
      printf("Bad exchange: \"%s\" should be DX\n", $0) > "/dev/stderr";
    }
  }
}
