#!/usr/bin/python3
#****************************************************************************
#  dtb2txt:   Convert a Win-Test .dtb file (prefill database file) in binary
#             format to blank-separated text file, one line per call
#
#  Version:   2.0 - Updated with permission from N6TV by G4IRN to be compatible with Python V3
#
#  Time-stamp: "14 February 2022 08:11 UTC"
#
#  Usage:     dtb2txt.py FileName[.dtb]
#
#  Input:     .dtb file with one callsign and exchange per line, binary
#
#  Example    dtb2txt EU_HF   - reads EU_HF.dtb, writes EU_HF.txt
#
#  Language:  Python v3 or later
#
#  Copyright: (c) 2018, 2022 Robert A. Wilson, N6TV
#             All Rights Reserved
#****************************************************************************
import sys                              # For argv and exit
#import struct                           # For pack and unpack
#import string                           # For str
import os.path                          # For basename

CALLWIDTH = 14                          # Callsign is 14 bytes, nul-padded
INFOWIDTH = 12                          # Exchange info is 12 bytes max, nul-padded

callInfo = {}                           # Empty dictionary keyed by call
                                        # Value is Zone or HQ Info or exchange data
#
# Should see one command line argument.  Print help text if requested.
#
runName = os.path.basename(sys.argv[0])
print (runName, "Version 2.0 by N6TV - Updated For Python v3 by G4IRN")
if (len(sys.argv) != 2) or sys.argv[1].lower() in ("-?", "-h", "-help", "--help"):
    print ("Usage: ", runName.strip(".py"), "FileName[.dtb]")
    print ("        Writes  FileName.txt")
    sys.exit(8)

dtbFile = sys.argv[1]

# If file name does not end with ".dtb" and contains no periods, append ".dtb"
if not dtbFile.lower().endswith(".dtb") and dtbFile.find(".") == -1:
    dtbFile += ".dtb"

# Change file extension to .txt
txtFile = dtbFile[:dtbFile.rfind(".")] + ".txt"
inFile = open(dtbFile, "r", encoding = "utf-8", errors = 'replace')

outFile = open(txtFile, "w")

#
# Read input .DTB file
#
print ("Reading", inFile.name)
print ("Writing", outFile.name)

numLines = 0
callsign = inFile.read(CALLWIDTH).strip("\x00")
info = inFile.read(INFOWIDTH).strip("\x00")

while len(callsign) > 0:
   numLines += 1
   callInfo[ callsign ] = info
   callsign = inFile.read(CALLWIDTH).strip("\x00")
   info = inFile.read(INFOWIDTH).strip("\x00")

for callsign in sorted(callInfo):
   outFile.write("%-14s%-12s\n" % (callsign, callInfo[ callsign ]))

print (numLines, "records read from", inFile.name)
print (len(callInfo), "lines written to", outFile.name)

inFile.close()
outFile.close()
