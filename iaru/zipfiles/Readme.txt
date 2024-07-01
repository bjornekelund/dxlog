How to Use the HQ Station Pre-fill Files in the IARU HF Contest

Send HQ callsign updates/corrections to Joe, OZ0J, contest@oz0j.dk

Latest addition (test call):   B7HQ CRAC

Last updated:  30 June 2024 16:52 UTC

Data files included in this Zip:

  iaru.txt - N1MM, SkookumLogger, UCXLog "Call History File" (text).
  iaru_n1mm_plus.txt - N1MM+ "Call History File" (text)
  iaruhq.txt - DXLog.net HQ pre-fill file
  iaru2024.adi - Writelog ADIF file (text)
  iaru2024.xdt - Win-Test "Extra Data" file (text)
  INITIAL.EX - TR4W Initial Exchange file (text)
  itu.dtb - Win-Test HQ station prefill database (binary)

N1MM and N1MM+:

1. Extract either iaru.txt (N1MM) or iaru_n1mm_plus.txt (N1MM+) from the ITU.zip file
2. From the N1MM or N1MM+ menu, select File | Import | Import Call History...
3. N1MM+:  Select iaru_n1mm_plus.txt
   N1MM:   Select iaru.txt
4. Click Open
5. From the menu, select Configure | Enable Call History Lookup
6. Enter B7HQ and the logger should prefill CRAC as the exchange

Writelog (TNX W5XD):

1. Extract iaru2024.adi from the ITU.zip file
2. From the Writelog menu, select Tools | Preset Exchange from ADI file
3. Select the iaru2024.adi file
4. Enter B7HQ and Writelog should prefill CRAC as the exchange

Win-Test:

1. Extract iaru2024.xdt to C:\ProgramData\Win-Test\Extras\
   (On Windows XP, extract to C:\Documents and Settings\All Users\Application Data\Win-Test\Extras\)
2. Extract itu.dtb to C:\ProgramData\Win-Test\Databases\
   (On Windows XP, extract to C:\Documents and Settings\All Users\Application Data\Win-Test\Databases\)
3. From the Win-Test menu, select Tools | Data Entry | Exchange Guessing | Automatically
4. Press Alt-X to view the "Extra information" window
   Right click on the window, select "Extra data files..."
   Click [Add...], select iaru2024.xdt, click OK
5. Enter B7HQ and Win-Test should prefill CRAC as the exchange
   "CRAC" should also appear in the Extra Information window

   NOTE: For an explanation of why both files should be updated, please read this post:
   http://lists.f5mzn.org/pipermail/support/2017-June/085580.html

DXLog.net (TNX W9PA, SM7IUN):

1. Select File | Update database
   -or-
   Extract iaruhq.txt to %appdata%\DXLog.net\Database\
2. From the DXLog menu, select Tools | Data Entry | Exchange Guessing | Automatically
3. Extract iaru2024.xdt to a location of your choice
4. In DXLog, select Windows | Extra information
    Right-click on the window and select "Extra data files"
    Click the Add button, browse to the above selected location, select iaru2024.xdt, and click OK
5. Enter B7HQ and DXLog should prefill CRAC as the exchange.
   "CRAC" should also appear in the Extra information window

TR4W (TNX N4TZ):

1. Extract INITIAL.EX to TR4W root directory (same location as CTY.DAT file and TRMASTER.DTA)
2. Enter B7HQ and TR4W should prefill CRAC as the exchange

SkookumLogger (TNX K1GQ):

1. Choose File > Update IARU HQ Call History
2. Select the IARU.TXT file in the file chooser
3. Check that B7HQ prefills HQ code CRAC

UcxLog (TNX OZ1BII):
 
1. Extract iaru.txt to C:\UcxLog\MEMBER\
2. Remember to delete old IARU files in C:\UcxLog\MEMBER\
3. Enter B7HQ and the logger should prefill CRAC as the exchange in the Membership window

73,
Bob, N6TV
n6tv@arrl.net
