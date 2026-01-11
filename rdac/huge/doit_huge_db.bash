dos2unix rda.txt
gawk '
BEGIN {
  printf("#00 RDA Contest HUGE prefill database.\n");
  printf("#01 Based on data from https://rdaward.org.\n");
  printf("#02 File created on %s.\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  if ($2 ~ /[0-9,A-Z]/ && $3 ~ /[A-Z]{2}-[0-9]{2}/) {
    calll = length($2) - 2;
    call = substr(substr($2, 2), 1, calll);
    rda = substr($3,2,2) substr($3,5,2);
#    printf("call=%s rda=%s\n", call, rda) > "/dev/stderr";
    callist[call] = call;
    rdalist[call] = rda;
  }
  else {
#    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (cs in callist) {
    printf("%s=%s\n", callist[cs], rdalist[cs]);
  }
}' rda.txt | sort | sed 's/#0. /# /g' > RDAC_huge_db.txt
unix2dos RDAC_huge_db.txt
