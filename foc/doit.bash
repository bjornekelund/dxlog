#!/bin/bash

curl -s https://foc.telegraphy.de/db/FOC_db.txt --output FOC_db.txt
curl -s https://foc.telegraphy.de/db/foc.xdt --output foc.xdt

echo "Downloaded FOC_db.txt and foc.xdt"
unix2dos -q foc.xdt FOC_db.txt
exit
