#!/bin/bash
gawk '
BEGIN {
  for (i = 1; i < 10; i++) {
    printf("POINTS_FIELD_BAND_MODE=DEST->RCVD:^(0?%d)$;DEST->RECINFO:^R$;ALL;ALL;%d\n", i, i + 5);
    printf("POINTS_FIELD_BAND_MODE=DEST->RCVD:^(0?%d)$;!DEST->RECINFO:^R$;ALL;ALL;%d\n", i, i);
  }
  for (i = 10; i < 91; i++) {
    printf("POINTS_FIELD_BAND_MODE=DEST->RCVD:^%d$;DEST->RECINFO:^R$;ALL;ALL;%d\n", i, i + 5);
    printf("POINTS_FIELD_BAND_MODE=DEST->RCVD:^%d$;!DEST->RECINFO:^R$;ALL;ALL;%d\n", i, i);
  }
}
{}' /dev/null > points.txt

unix2dos -q points.txt

exit
