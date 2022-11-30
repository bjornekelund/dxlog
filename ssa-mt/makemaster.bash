awk 'BEGIN {FS="="} {print $1 " " $1 " " $2}' SSA_MT_db_noheader.txt | sort > SSA_master.txt
