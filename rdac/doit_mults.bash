#bin/bash
rm rda_eng.txt
wget http://rdaward.org/rda_eng.txt
dos2unix -q rda_eng.txt
sed 's/  /\t/g' < rda_eng.txt | sed 's/\/ /\//g' | sed 's/ \/\t/\/\t/g' |\
sed 's/ \t/\t/g' | sed 's/\t /\t/g' | sed 's/\t\t/\t/g' > .tmp1_rda.txt

awk '
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
}' < .tmp1_rda.txt > multipliers_rda.txt
unix2dos -q multipliers_rda.txt
echo Created multipliers_rda.txt
exit
