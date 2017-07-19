:START
@ECHO OFF
for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%
echo Current time is %mytime% %date% >> c:\install\syncnas\testmydisklog.txt
set /a x=0

:WHILE
if %x% lss 5 (
 echo Loop Number %x% >> c:\install\syncnas\testmydisklog.txt
 set /a x+=1
 vol c:
 echo C Drive Error %ERRORLEVEL% >> c:\install\syncnas\testmydisklog.txt
 if %ERRORLEVEL% EQU 0 goto DDRIVE
 if %ERRORLEVEL% EQU 1 goto MISSING
)
echo LOOP COMPLETED >> c:\install\syncnas\testmydisklog.txt
echo Disk missing reboot set >> c:\install\syncnas\testmydisklog.txt
echo . >> c:\install\syncnas\testmydisklog.txt
EXIT/B 1

:DDRIVE
vol d:
echo D Drive Error %ERRORLEVEL% >> c:\install\syncnas\testmydisklog.txt
if %ERRORLEVEL% EQU 0 goto EDRIVE
if %ERRORLEVEL% EQU 1 goto MISSING

:EDRIVE
vol e:
echo E Drive Error %ERRORLEVEL% >> c:\install\syncnas\testmydisklog.txt
if %ERRORLEVEL% EQU 0 goto FDRIVE
if %ERRORLEVEL% EQU 1 goto MISSING

:FDRIVE
vol f:
echo F Drive Error %ERRORLEVEL% >> c:\install\syncnas\testmydisklog.txt
if %ERRORLEVEL% EQU 0 goto EOF
if %ERRORLEVEL% EQU 1 goto MISSING

:MISSING
echo MISSING DRIVE >> c:\install\syncnas\testmydisklog.txt
devcon -rescan
ping 8.8.8.8
ping 8.8.8.8
goto WHILE

:EOF
echo ALL GOOD >> c:\install\syncnas\testmydisklog.txt
echo . >> c:\install\syncnas\testmydisklog.txt
EXIT/B 0