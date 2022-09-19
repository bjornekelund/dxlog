#!/bin/bash
OUTFILE=silly.txt

gawk '
BEGIN {
  modes[0] = "CW";
  modes[1] = "SSB";
  modes[2] = "ALL";

  points["CW"] = 3;
  points["SSB"] = 2;
  points["ALL"] = 1

  for (i = 65; i < 83; i++) {
    chr[i] = i;

  bandregex="160|80|40";
  for (first = 65; first < 83; first++) {
    for (second = 65; second < 83; second++) {
      thisgrid = sprintf("%c", first) sprintf("%c", second);
      printf("# Rules for station with grid %s for bands %s\n", thisgrid, bandregex)
      for (modei = 0; modei < 3; modei++) {
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s$;DEST->RCVD:^%s$;^(%s)$;%s;%d\n", thisgrid, thisgrid, bandregex, modes[modei], points[modes[modei]] * 1);
        gridregex = "";
        notfirst = 0;
        for (fd = -1; fd < 2; fd++) {
          for (sd = -1; sd < 2; sd++) {
            if (fd != 0 || sd != 0) {
              fn = (first - 65 + fd + 17) % 17 + 65;
              sn = (second - 65 + sd + 17) % 17 + 65;
              if (notfirst) {
                gridregex = gridregex "|"
              }
              gridregex  = gridregex sprintf("%c", fn) sprintf("%c", sn);
            }
            notfirst = 1;
          }
        }
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s$;DEST->RCVD:^(%s)$;^(%s)$;%s;%d\n", thisgrid, gridregex, bandregex, modes[modei], points[modes[modei]] * 2);
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s$;ALL;^(%s)$;%s;%d\n", thisgrid, bandregex, modes[modei], points[modes[modei]] * 3);
      }
    }
  }

  bandregex="20|15|10";
  for (first = 65; first < 83; first++) {
    for (second = 65; second < 83; second++) {
      thisgrid = sprintf("%c", first) sprintf("%c", second);
      printf("# Rules for station with grid %s for bands %s\n", thisgrid, bandregex)
      for (modei = 0; modei < 3; modei++) {
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s$;DEST->RCVD:^%s$;^(%s)$;%s;%d\n", thisgrid, thisgrid, bandregex, modes[modei], points[modes[modei]] * 3);
        gridregex = "";
        notfirst = 0;
        for (fd = -1; fd < 2; fd++) {
          for (sd = -1; sd < 2; sd++) {
            if (fd != 0 || sd != 0) {
              fn = (first - 65 + fd + 17) % 17 + 65;
              sn = (second - 65 + sd + 17) % 17 + 65;
              if (notfirst) {
                gridregex = gridregex "|"
              }
              gridregex  = gridregex sprintf("%c", fn) sprintf("%c", sn);
            }
            notfirst = 1;
          }
        }
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s$;DEST->RCVD:^(%s)$;^(%s)$;%s;%d\n", thisgrid, gridregex, bandregex, modes[modei], points[modes[modei]] * 1);
        printf("POINTS_FIELD_BAND_MODE=CONFIG->EXCHANGE:^%s$;ALL;^(%s)$;%s;%d\n", thisgrid, bandregex, modes[modei], points[modes[modei]] * 2);
      }
    }
   }
  }
}' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit

  printf("# Points calculation. Members are 2 points. Non-members are 1 point.\n");
  printf("# Member callsigns from www.bavarian-contest-club.de as of %s\n", strftime("%Y-%m-%d"));
  printf("POINTS_FIELD_BAND_MODE=ALL;DEST->DXCC:^$;ALL;ALL;0\n");
  printf("POINTS_FIELD_BAND_MODE=DEST->CALL:^DA0BCC$;ALL;ALL;ALL;5\n");
  printf("POINTS_FIELD_BAND_MODE=DEST->CALL:^(%s)$;ALL;ALL;ALL;2\n", string);
  printf("POINTS_FIELD_BAND_MODE=ALL;ALL;ALL;ALL;1\n\n");



  if ($1 ~ /^[0-9,A-Z]/ && $3 ~ /^(AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|KS|KY|LA|ME|MD|MA|MI|MS|MN|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WI|WV|WY|AB|BC|LB|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)$/) {
    printf("%s=%s\n", toupper($1), toupper($3));
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: %s\n", $0) > "/dev/stderr";
