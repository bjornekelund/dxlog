#!/bin/bash
PROFILE=`wslpath "$(wslvar USERPROFILE)"`
DXCFILE=$PROFILE/source/repos/k1xm/DXLog.net/DXLog.net/Database/dxclist.txt
OUTFILE=dxclist.txt
TEMPFILE=.tempdxclist

# Script to test if URLs from a file are alive
# Expected format: CALLSIGN=url;port;YES;;

echo Checking $DXCFILE
cp $DXCFILE $TEMPFILE
dos2unix -q $TEMPFILE

# Process each line
while IFS= read -r line || [ -n "$line" ]; do
    # Skip empty lines
    [ -z "$line" ] && continue
    
    # Extract the part between = and first ;
    # Format: CALLSIGN=server;port;...
    if [[ $line =~ =([^=]+)$ ]]; then
        # Get everything after the =
        after_equal="${BASH_REMATCH[1]}"
        
        # Split by semicolon to get server and port
        IFS=';' read -r server port rest <<< "$after_equal"
        
        # Remove preceding star if present
        server="${server#\*}"
        
        # Get the callsign (part before = but after star if present)
        callsign="${line%%=*}"
        callsign="${callsign#\*}"

#        echo "Testing $callsign ($server:$port)... "
        
        if [[ $callsign != "LOCALHOST" ]]; then
            # Test connection with timeout of 5 seconds
            # Using /dev/tcp for portability (no telnet command needed)
            if timeout 5 bash -c "exec 3<>/dev/tcp/$server/$port" 2>/dev/null; then
                printf "Node %-9s ✓ ALIVE\n" "$callsign"
            else
                printf "Node %-9s ✗ DEAD\n" "$callsign"
            fi
        fi
    fi
done < "$TEMPFILE"

exit
