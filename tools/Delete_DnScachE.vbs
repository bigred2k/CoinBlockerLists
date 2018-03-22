If WScript.Arguments.length =0 Then
  	Set objShell = CreateObject("Shell.Application")
	objShell.ShellExecute "wscript.exe", Chr(34) & WScript.ScriptFullName & Chr(34) & " Run", , "runas", 1 
	Set WshShell = Nothing
Else  
        Set oShell = WScript.CreateObject ("WScript.Shell")
        oShell.run "cmd /k ipconfig /flushdns & start /wait net stop dnscache & start /wait net start dnscache & echo. & exit", 0, True
	Set oShell = Nothing
End If
