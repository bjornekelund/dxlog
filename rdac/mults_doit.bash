#bin/bash
OUTFILE=multipliers_rda.txt
FILE=rda_eng.txt

rm $FILE

echo Downloading $FILE
wget -q https://rdaward.org/$FILE
dos2unix -q $FILE

sed 's/  /\t/g' rda_eng.txt | sed 's/\/ /\//g' | sed 's/ \/\t/\/\t/g' |\
sed 's/ \t/\t/g' | sed 's/\t /\t/g' | sed 's/\t\t/\t/g' | awk '
BEGIN {
  printf("[MULTIPLIERS START]\n");
  FS="\t";
  max = 0;
}
{
  if ($1 ~ /[A-Z][A-Z]-[0-9][0-9]/ && $2 != "deleted") {
    printf("%s%s=%s\n", substr($1, 1, 2), substr($1, 4, 2), $2);
  }	  
}
END { 
  printf("[MULTIPLIERS END]\n");
}' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
