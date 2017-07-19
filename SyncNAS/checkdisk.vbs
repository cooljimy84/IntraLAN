Dim objResult

Set objShell = WScript.CreateObject("WScript.Shell")    
objResult = objShell.Run("C:\INSTALL\SyncNAS\devcon.exe rescan", 7, True)
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colDisks = objWMIService.ExecQuery _
    ("Select * from Win32_LogicalDisk Where DriveType = 3 AND VolumeName = 'BCRM'")

For Each objDisk in colDisks
    objResult = objShell.Run("chkdsk.exe " & objDisk.DeviceID & " /X", 1, True)  
Next