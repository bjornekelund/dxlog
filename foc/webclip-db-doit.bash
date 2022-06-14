INFILE=webclip.txt
OUTFILE=FOC_db.txt

dos2unix -q $INFILE
echo Parsing $INFILE

gawk '
BEGIN {
  FS=","
  max = 0;
  printf("#0 DXLog.net FOC members data base\n");
  printf("#1 Data scraped from g4foc.org\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($0 ~ /^[0-9]/) {
	mem = substr($0,1,4);
	gsub(/ /, "", mem);
	call = substr($0,8,6);
	gsub(/ /, "", call);
	name = substr($0,15,20);
	gsub(/  /, " ", name);
	gsub(/  /, " ", name);
	gsub(/  /, " ", name);
	gsub(/  /, " ", name);
	gsub(/  /, " ", name);
	gsub(/  /, " ", name);
	gsub(/ $/, "", name);
	printf("%s=%s;%s\n", call, name, mem);
	if (strtonum(mem) > max) max = strtonum(mem);
  }
}
END {
  printf("#3 Contains members up to #%d\n", max);
}' $INFILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
