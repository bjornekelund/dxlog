#!/bin/bash
OUTFILE=ASCHAMP_points.txt

gawk '
BEGIN {
  date = strftime("%Y-%m-%d");
  printf("#\n");
  printf("# Asiatic Russia Championship points file\n");
  printf("# File created %s.\n", date);
  printf("#\n");
  minlat = 4;
  maxlat = 9;
  minlong = 4;
  maxlong = 18;
  for (mylat = minlat; mylat <= maxlat; mylat++) {
    for (mylong = minlong; mylong <= maxlong; mylong++) {
      myexch = mylat mylong;
      for (lat = minlat; lat <= maxlat; lat++) {
        for (long = minlong; long <= maxlong; long++) {
          exch = lat long;
          latdiff = (lat < mylat) ? mylat - lat : lat - mylat;
          longdiff = (long < mylong) ? mylong - long : long - mylong;
          points = latdiff + longdiff + 5;
          printf("%s;%s=%d\n", myexch, exch, points);
        }
      }
    }
  }
}
{
}' /dev/null > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit
