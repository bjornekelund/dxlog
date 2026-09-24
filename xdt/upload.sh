#!/bin/sh
for file in *.xdt
do
  curl --silent --fail --show-error --user "`cat ../CREDENTIALS`" \
    --upload-file "$file" \
    "https://dxlog.net:2078/sw/files/download/extrainfo/$file"
    echo ": $file"
done

exit 0
