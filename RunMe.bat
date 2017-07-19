REM wscript c:\install\syncnas\checkdisk.vbs

@echo off
call :Resume
goto %current%
goto :eof

:one
::Test the disks and add script to Run key
call c:\install\syncnas\TestMyDisk.bat
if %ERRORLEVEL% EQU 0 goto TWO
if %ERRORLEVEL% EQU 1 goto FAILED

:failed
::Add script for Run service
c:\install\syncnas\nssm-2.24\win64\nssm.exe install RunSyncNAS "c:\install\syncnas\runme.bat"
c:\install\syncnas\nssm-2.24\win64\nssm.exe set RunSyncNAS AppExit * Exit
echo two >%~dp0current.txt
echo -- Section one --
shutdown -f -r -t 60
goto :eof

:two
::Remove script from Run service
c:\install\syncnas\nssm-2.24\win64\nssm.exe remove RunSyncNAS confirm
del %~dp0current.txt
echo -- Section two --
call c:\install\syncnas\syncnas.exe
goto :eof

:resume
if exist %~dp0current.txt (
    set /p current=<%~dp0current.txt
) else (
    set current=one
)