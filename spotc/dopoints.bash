#!/bin/bash
OUTFILE=pointsotc.txt

gawk '
BEGIN {
  modes[0] = "CW";
  modes[1] = "SSB";

  printf("POINTS_FIELD_BAND_MODE=!DEST->RECINFO:^OT$;ALL;^80$;ALL;RCVD\n");

  for (i = 20; i < 95; i++){
 
        numstring = "" i;
        printf("POINTS_FIELD_BAND_MODE=DEST->RCVD:^%d$;DEST->RECINFO:^OT$;^80$;ALL;%d\n", i, i + 25);
        printf("POINTS_FIELD_BAND_MODE=DEST->RCVD:^%d$;DEST->RECINFO:^OT$;^80$;ALL;%d;DEST->CALL:^SP0OTC$\n", i, i + 100);
}
}' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
