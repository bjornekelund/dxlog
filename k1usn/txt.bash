#bin/bash
OUTFILE=K1USN_SST_db.txt
gawk '
BEGIN {
  FS=","
}
{
  if (substr($1, 1, 1) ~ /[0-9,A-Z]/ && $2 != "") {
    ID = $3;
    if ($1 !~ /^(A[A-L]|K|N|W|C[F-K]|V[A-G]VX|VY9|X[LM]|C[F-Z]|V[A-Y]|X[J-O])/) {
      ID = "DX";
#      printf("Assign DX: \"%s\"\n", $0) > "/dev/stderr";
    }
    if ((ID == "" && $2 == "") || ID !~ /[A-Z]{2}|/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    else
      printf("%s=%s;%s\n", toupper($1), toupper($2), ID);
  }
}
END {
  printf("#0 K1USN Slow Speed Test participants database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 Updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > $OUTFILE
echo $OUTFILE "created"
unix2dos -q $OUTFILE
exit
