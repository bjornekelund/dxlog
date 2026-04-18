BEGIN {
  split("1200W,1100W,1000W,0930W,0900W,0800W,0700W,0600W,0500W,0400W,0330W,0300W,0200W,0100W,0000Z,0100E,0200E,0300E,0330E,0400E,0430E,0500E,0530E,0545E,0600E,0630E,0700E,0800E,0845E,0900E,0930E,1000E,1030E,1100E,1200E,1245E,1300E,1400E", zones, ",");
  for (i in zones)
  {
    hour = substr(zones[i], 1, 2);
    minute= substr(zones[i], 3, 2);
    dir = substr(zones[i], 5, 1);
    value[zones[i]] = (hour + minute / 60) * (dir == "W" ? -1 : 1);
    # printf("zone=%s;hour=%s;minute=%s;dir=%s;value=%f\n", zones[i], hour, minute, dir, value[zones[i]]) > "/dev/stderr";
  }
  printf("# World Time Zone Challenge points table\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
  for (i in zones)
  {
    for (j in zones)
    {
      d1 = value[zones[i]] - value[zones[j]];
      diff1 = int(d1 < 0 ? -d1 : d1);
      d2 = value[zones[j]] - value[zones[i]];
      diff2 = int(d2 < 0 ? -d2 : d2);
      diff = 1 + (diff1 < diff2 ? diff1 : diff2);
      printf("%s;%s=%d\n", zones[i], zones[j], diff);
    }
  }
}
{}
