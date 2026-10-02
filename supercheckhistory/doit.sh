#!/usr/bin/env bash
#ALL="RDAC STEW-PERRY NAQP-CW QSOP_AR QSOP_AL"
ALL="QSOP_AC QSOP_AL QSOP_AR QSOP_AZ QSOP_BC"
ALL="$ALL 9A-DX ARI-DX ARRL-10M ARRL-160M AWT NAQP RDAC STEW-PERRY"

ALL="[A-Z0-9]*"

for contest in $ALL; do
    echo ---
    ./supercheckhistory.sh $contest
done

exit

