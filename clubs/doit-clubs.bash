#/bin/bash
# Move to correct folder to allow execution from cron
[ -d "/home/sm7iun/cwclubs" ] && cd /home/sm7iun/cwclubs

echo Job started `date`
START=$SECONDS

rm cw_clubs_call_history.txt
wget -q --user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" --no-hsts http://www.g4bki.com/call_history/cw_clubs_call_history.txt -O raw.txt
echo Downloaded cw_clubs_call_history.txt with `wc -l < raw.txt` lines

sed -b 's/\x1A//g' < raw.txt > cw_clubs_call_history.txt

dos2unix -q cw_clubs_call_history.txt
cp cw_clubs_call_history.txt tmp.txt

echo "#TITLE CW clubs (by G4BKI)" > CWClubs.xdt

awk '
BEGIN {
  FS=",";
  max = 0;
  callloc = 1;
  clubloc = 4;
  numloc = 3;
  nameloc = 2;
}
{
  if (!($0 ~ /#/) && $1 ~ /!!Order!!/) {
#    printf("Found order: %s NF=%d\n", $0, NF) > "/dev/stderr";
    for (i = 2; i <= NF; i++) {
      if ($i ~ /Call/)
        callloc = i - 1;
       if ($i ~ /UserText/)
        clubloc = i - 1;
      if ($i ~ /CK/)
        numloc = i - 1;
      if ($i ~ /Name/)
        nameloc = i - 1;
      if (!($0 ~ /CK/)) numloc = 0;
      if (!($0 ~ /Name/)) nameloc = 0;
    }
#    printf("Order: call=%d club=%d num=%d\n", callloc, clubloc, numloc) > "/dev/stderr";
  }
  else {
     if (!($0 ~/#/) && $callloc ~ /[A-Z,0-9]/ && $clubloc != "") {
#       if ($clubloc ~/^HSC/) {
#         printf("callloc=%d clubloc=%d numloc=%d call=%s ", callloc, clubloc, numloc, $callloc) > "/dev/stderr";
#         printf("club=%s num=%s\n", $clubloc, $numloc) > "/dev/stderr";
#       }
       calls[$callloc] = $callloc;
       mems = $clubloc;
#       if (numloc != 0 && $numloc != "") mems = mems "(" $numloc ")";
       clubs[$callloc] = clubs[$callloc] mems " ";
       if (nameloc != 0 && $nameloc != "") names[$callloc] = $nameloc " ";
     }
     else {
#       printf("Bad data: %s\n", $0) > "/dev/stderr";
     }
  }
}
END {
  for (call in calls) {
    printf("%s %s%s\n", call, names[call], clubs[call]);
  }
}' < tmp.txt | sort >> CWClubs.xdt
unix2dos -q CWClubs.xdt
echo Created CWClubs.xdt with `wc -l < CWClubs.xdt` calls
ftp -n 23.229.199.134 <<END_SCRIPT
binary
quote USER bjorn@dxlog.net
quote PASS ?Hv(wycM;Nb4
cd sw/files/download/extrainfo
put CWClubs.xdt
quit
END_SCRIPT
echo Uploaded CWClubs.xdt with `wc -l < CWClubs.xdt` calls
echo Job ended `date` and took $((SECONDS-START)) seconds
echo ----
exit 0
