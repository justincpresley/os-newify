Write-Output "Stopping Windows Update Service..."
Stop-Service -Name wuauserv -Force
Stop-Service -Name bits -Force
sleep 3
get-service bits, wuauserv

Write-Output "Removing System Files..."
Remove-Item -Recurse -Force "$env:windir\prefetch\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\softwaredistribution\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\temp\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:systemdrive\Windows.Old" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:temp" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:userprofile\AppData\Local\Microsoft\Windows\INetCache\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:systemdrive\temp" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\CarbonBlack" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\CbsTemp" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\ccmcache" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\CCM\Temp" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\CCM\Inventory\Temp" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\CCM\Logs\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\CCM\SystemTemp" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\CCM\Staging\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:programdata\Microsoft\Windows\WER\Temp\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:programdata\Microsoft\Windows\WER\ReportArchive\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:programdata\Microsoft\Windows\WER\ReportQueue\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:LocalAppData\Microsoft\Windows\Explorer\*.db" -ErrorAction SilentlyContinue

takeown /F "$env:programdata\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /R
icacls "$env:programdata\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /grant administrators:F /t
Write-Output "" > "$env:programdata\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
Write-Output Clear successful: "$env:programdata\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\DtcInstall.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\comsetup.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\PFRO.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\setupact.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\setuperr.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\setupapi.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\Panther\*
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\inf\setupapi.app.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\inf\setupapi.dev.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\inf\setupapi.offline.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\Performance\WinSAT\winsat.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\debug\PASSWD.LOG
Remove-Item -Force -ErrorAction SilentlyContinue $env:LocalAppData\Microsoft\Windows\WebCache\*.*
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\ServiceProfiles\LocalService\AppData\Local\Temp\*.*
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\Logs\CBS\CBS.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\Logs\DISM\DISM.log
Remove-Item -Force -ErrorAction SilentlyContinue "$env:SystemRoot\Logs\SIH\*"
Remove-Item -Force -ErrorAction SilentlyContinue "$env:LocalAppData\Microsoft\CLR_v4.0\UsageTraces\*"
Remove-Item -Force -ErrorAction SilentlyContinue "$env:LocalAppData\Microsoft\CLR_v4.0_32\UsageTraces\*"
Remove-Item -Force -ErrorAction SilentlyContinue "$env:SystemRoot\Logs\NetSetup\*"
Remove-Item -Force -ErrorAction SilentlyContinue "$env:SystemRoot\System32\LogFiles\setupcln\*"
Remove-Item -Force -ErrorAction SilentlyContinue "$env:SystemRoot\Temp\CBS\*"
takeown /f $env:SystemRoot\Logs\waasmedic /r -Value y
icacls $env:SystemRoot\Logs\waasmedic /grant administrators:F /t
Remove-Item -Recurse -ErrorAction SilentlyContinue $env:SystemRoot\Logs\waasmedic
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\System32\catroot2\dberr.txt
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\System32\catroot2.log
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\System32\catroot2.jrs
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\System32\catroot2.edb
Remove-Item -Force -ErrorAction SilentlyContinue $env:SystemRoot\System32\catroot2.chk
Remove-Item -Force -ErrorAction SilentlyContinue "$env:SystemRoot\Logs\SIH\*"
Remove-Item -Force -ErrorAction SilentlyContinue "$env:SystemRoot\Traces\WindowsUpdate\*"
Remove-Item -Force -ErrorAction SilentlyContinue "$env:LocalAppData\Microsoft\Windows\INetCache\IE\*"
reg delete "HKCU\SOFTWARE\Microsoft\Internet Explorer\TypedURLs" /va /f
reg delete "HKCU\SOFTWARE\Microsoft\Internet Explorer\TypedURLsTime" /va /f
Remove-Item -Recurse -ErrorAction SilentlyContinue "$env:LocalAppData\Microsoft\Internet Explorer"
Remove-Item -Recurse -ErrorAction SilentlyContinue "$env:appdata\Microsoft\Windows\Cookies"
Remove-Item -Recurse -ErrorAction SilentlyContinue "$env:userprofile\Cookies"
Remove-Item -Recurse -ErrorAction SilentlyContinue "$env:userprofile\Local Settings\Traces"
Remove-Item -Recurse -ErrorAction SilentlyContinue "$env:LocalAppData\Temporary Internet Files"
Remove-Item -Recurse -ErrorAction SilentlyContinue "$env:LocalAppData\Microsoft\Windows\Temporary Internet Files"
Remove-Item -Recurse -ErrorAction SilentlyContinue "$env:LocalAppData\Microsoft\Windows\INetCookies\PrivacIE"
Remove-Item -Recurse -ErrorAction SilentlyContinue "$env:LocalAppData\Microsoft\Feeds Cache"
Remove-Item -Recurse -ErrorAction SilentlyContinue "$env:LocalAppData\Microsoft\InternetExplorer\DOMStore"

Clear-RecycleBin -Force -ErrorAction SilentlyContinue
Clear-BCCache -Force -ErrorAction SilentlyContinue