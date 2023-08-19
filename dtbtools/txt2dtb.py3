#!/usr/bin/python
#****************************************************************************
#  txt2dtb:   Convert a text file (callsign, exchange data) to Win-Test .dtb
#             binary format (prefill database file)
#
#  Version:   2.0 - Updated with permission from N6TV by G4IRN to be compatible with Python v3.
#
#  Time-stamp: "13th February 2022 16:06"
#
#  Usage:     txt2dtb.py FileName[.txt]
#
#  Input:     Text file with one callsign and exchange per line, blank-separated
#
#  Example    txt2dtb EU_HF   - reads EU_HF.txt, writes EU_HF.dtb
#             txt2dtb itu.xdt - reads itu.xdt, writes itu.dtb
#             txt2dtb iota.xdt master.scp - reads both files, writes iota.dtb
#
#  Language:  Python v3 or later
#
#  Copyright: (c) 2012,2015,2022 Robert A. Wilson, N6TV
#             All Rights Reserved
#****************************************************************************
import sys                              # For argv and exit
import struct                           # For pack and unpack
import binascii                         # For b2a_hex
import string                           # For str
import os.path                          # For basename

CALLWIDTH = 14                          # Callsign is 14 bytes, nul-padded
INFOWIDTH = 12                          # Exchange info is 12 bytes max, nul-padded

callInfo = {}                           # Empty dictionary keyed by call
                                        # Value is Zone or HQ Info
#
# Should see one command line arguments.  Print help text if requested.
#
runName = os.path.basename(sys.argv[0])
print (runName, "Version 2.0 by N6TV - Updated For Python v3 by G4IRN")
if (len(sys.argv) not in [2,3]) or sys.argv[1].lower() in ("-?", "-h", "-help", "--help"):
    print ("Usage: ", runName.strip(".py"), "FileName[.txt] [ master.scp ]")
    print ("        Writes  FileName.dtb")
    sys.exit(8)

txtFile = sys.argv[1]

if len(sys.argv) == 3:
    mastFile = sys.argv[2]
else:
    mastFile = ""

# If file name does not end with ".txt" and contains no periods, append ".txt"
if not txtFile.lower().endswith(".txt") and txtFile.find(".") == -1:
    txtFile += ".txt"

# Change file extension to .dtb
dtbFile = txtFile[:txtFile.rfind(".")] + ".dtb"

inFile = open(txtFile, "rU")

#
# Read input .TXT file
#
print ("Reading", inFile.name)
lines = inFile.readlines()
for line in lines:
    if line.isspace():                  # Ignore empty lines
        print ("Ignoring:", line.strip())
        continue

    if line.startswith("#"):            # Ignore header line in .xdt file
        print ("Ignoring:", line.strip())
        continue

    # Treat all commas as white space (e.g. 4L0HQ,,,,NARG)
    line = line.replace(",", " ")
    words = line.split()

    # If not enough words on line
    if len(words) < 2:
        print ("Ignoring:", line.strip())
        continue

    call = words[0].strip()
    info = words[1].strip(" \n")        # Remove white space, trailing newline
    info = info.replace("-","")         # Remove hyphens, if any
    info = info.replace(".","")         # Remove periods, if any

    if callInfo.get(call, "") != "":
        print ("Duplicate entry found:")
        print (call, callInfo.get(call))
        print (line.strip())

    callInfo[ call ] = info

print (len(lines), "lines read.")

inFile.close()
print (len(lines), "lines read.")

#
# Read input MASTER file, if any
#
if mastFile != "":
    inFile = open(mastFile, "rU")
    print ("Reading", inFile.name)
    lines = inFile.readlines()
    for line in lines:
        if line.isspace():                  # Ignore empty lines
            print ("Ignoring:", line.strip())
            continue

        if line.startswith("#"):            # Ignore header line in .xdt file
            print ("Ignoring:", line.strip())
            continue

        # Treat all commas as white space (e.g. 4L0HQ,,,,NARG)
        line = line.replace(",", " ")
        words = line.split()

        call = words[0].strip()
        info = ""

        # If data not already pre-loaded
        if callInfo.get(call, "") == "":
            callInfo[ call ] = info

    print (len(lines), "lines read.")


#
# Write .dtb file
#
outFile = open(dtbFile, "wb")
print ("Writing", outFile.name)

for call in sorted(callInfo):

  first_part = call.ljust(CALLWIDTH,chr(0))
  second_part = callInfo[call].ljust(INFOWIDTH,chr(0))

  outFile.write(first_part.encode('utf-8'))
  outFile.write(second_part.encode('utf-8'))


print (len(callInfo), "records written.")

inFile.close()
outFile.close()
