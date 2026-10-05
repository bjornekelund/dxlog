#!/bin/sh
for file in *.xdt
do
  if curl -o /dev/null --silent --fail --show-error --user "`cat ../CREDENTIALS`" \
    --upload-file "$file" "https://dxlog.net:2078/sw/files/download/extrainfo/$file";
  then
    echo "Uploaded $file with `wc -c < $file` lines"
  else
    echo "ERROR: Failed to upload $file"
    exit 1
  fi  
done

exit 0
