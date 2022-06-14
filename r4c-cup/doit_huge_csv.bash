FILE=rda.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
}
{
  if ($2 ~ /[0-9,A-Z\/]+/ && $3 ~ /[A-Z,a-z]{2}-[0-9]{2}/) {
    calll = length($2) - 2;
    call = substr(substr($2, 2), 1, calll);
    rda = substr(toupper($3),2,2) substr(toupper($3),5,2);
#    printf("call=%s rda=%s\n", call, rda) > "/dev/stderr";
    printf("%s,%s\n", call, rda);
  }
  else {
    printf("Bad data: %s\n", $0) > "/dev/stderr";
  }
}
END {
}' $FILE | sort | sed 's/#. /# /g' > RDAC_huge_csv.txt

echo Created RDAC_huge_csv.txt
unix2dos -q RDAC_huge_csv.txt

exit
