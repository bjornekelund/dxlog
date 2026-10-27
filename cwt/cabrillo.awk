BEGIN {
  printf("START-OF-LOG: 3.0\n");
  printf("CREATED-BY: DXLog.net\n");
  printf("CONTEST: CW-OPS\n");
  printf("CALLSIGN: SM7IUN\n");
  printf("CATEGORY-OPERATOR: SINGLE-OP\n");
  printf("CATEGORY-TRANSMITTER: ONE\n");
  printf("CATEGORY-ASSISTED: ASSISTED\n");
  printf("CATEGORY-POWER: HIGH\n");
  printf("CATEGORY-BAND: ALL\n");
  printf("CATEGORY-MODE: CW\n");
  printf("NAME: Bjorn Ekelund\n");
  printf("ADDRESS: Naktergalsvagen 16C\n");
  printf("ADDRESS-CITY: Bjarred\n");
  printf("ADDRESS-POSTALCODE: 23734\n");
  printf("ADDRESS-COUNTRY: Sweden\n");
  FS = "[,;=]";
  call = 99;
  state = 99;
  name = 99;
  qsotime = mktime(strftime("%Y %m %d") " 19 00 00");
  # printf("Start time %s\n", strftime("%Y-%m-%d %H:%M:%S", qsotime)) > "/dev/stderr";
  TZ=UTC;
}
{
  if ($0 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    state = FindColumn("State|Exch1");
    name = FindColumn("Name");
    printf("%s --> call=%d state=%d name=%d\n", $0, call, state, name) > "/dev/stderr";
  }
  else if ($0 !~ /^(#|!|$)/)
  {
    # printf("QSO time %s\n", strftime("%Y-%m-%d %H:%M:%S", qsotime)) > "/dev/stderr";
    qsodate = strftime("%Y-%m-%d", qsotime);
    qsohours = strftime("%H%M", qsotime);
    freq = 3523;
    mode = "CW";
    owncall = "SM7IUN";
    ownname = "BJORN";
    ownnumber = 2101;
    printf("QSO: %5d %2s %10s %04d %-14s %-10s %-5s %-14s %-10s %s\n", freq, mode, qsodate, qsohours, owncall, ownname, ownnumber, $call, toupper($name), $state);
    qsotime += 20; // 20 seconds between QSO
  }
}


# QSO: 21032 CW 2026-08-12 1900 SM7IUN        BJORN      2101  LY2MM         AL         3532  
# QSO: 21030 CW 2026-08-12 1900 SM7IUN        BJORN      2101  K3WW          CHAS       178   
# QSO: 21029 CW 2026-08-12 1901 SM7IUN        BJORN      2101  PA3AAV        GERT       2624  
# QSO: 21030 CW 2026-08-12 1902 SM7IUN        BJORN      2101  EA1X          JUAN       2562  
# QSO: 21030 CW 2026-08-12 1902 SM7IUN        BJORN      2101  WG3J          ERIC       2473  
# QSO: 21035 CW 2026-08-12 1903 SM7IUN        BJORN      2101  AA3B          BUD        242   
# QSO: 21033 CW 2026-08-12 1904 SM7IUN        BJORN      2101  G4PVM         PAUL       2413  
