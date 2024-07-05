function New-FolderForced {
  [CmdletBinding(SupportsShouldProcess = $true)]
  param (
	[Parameter(Position = 0, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
	[string]
    $Path
  )
  process {
    if (-not (Test-Path $Path)) {
      Write-Verbose "-- Creating full path to:  $Path"
      New-Item -Path $Path -ItemType Directory -Force
    }
  }
}

Write-Output "Disabling telemetry via Group Policies"
New-FolderForced -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" 0

Write-Output "Adding telemetry domains to hosts file"
$hosts_file = "$env:systemroot\System32\drivers\etc\hosts"
$domains = @(
  "184-86-53-99.deploy.static.akamaitechnologies.com"
  "a-0001.a-msedge.net"
  "a-0002.a-msedge.net"
  "a-0003.a-msedge.net"
  "a-0004.a-msedge.net"
  "a-0005.a-msedge.net"
  "a-0006.a-msedge.net"
  "a-0007.a-msedge.net"
  "a-0008.a-msedge.net"
  "a-0009.a-msedge.net"
  "a1621.g.akamai.net"
  "a1856.g2.akamai.net"
  "a1961.g.akamai.net"
  "a248.e.akamai.net"            # makes iTunes download button disappear (#43)
  "a978.i6g1.akamai.net"
  "a.ads1.msn.com"
  "a.ads2.msads.net"
  "a.ads2.msn.com"
  "ac3.msn.com"
  "ad.doubleclick.net"
  "adnexus.net"
  "adnxs.com"
  "ads1.msads.net"
  "ads1.msn.com"
  "ads.msn.com"
  "aidps.atdmt.com"
  "aka-cdn-ns.adtech.de"
  "a-msedge.net"
  "any.edge.bing.com"
  "a.rad.msn.com"
  "az361816.vo.msecnd.net"
  "az512334.vo.msecnd.net"
  "b.ads1.msn.com"
  "b.ads2.msads.net"
  "bingads.microsoft.com"
  "b.rad.msn.com"
  "bs.serving-sys.com"
  "c.atdmt.com"
  "cdn.atdmt.com"
  "cds26.ams9.msecn.net"
  "choice.microsoft.com"
  "choice.microsoft.com.nsatc.net"
  "compatexchange.cloudapp.net"
  "corpext.msitadfs.glbdns2.microsoft.com"
  "corp.sts.microsoft.com"
  "cs1.wpc.v0cdn.net"
  "db3aqu.atdmt.com"
  "df.telemetry.microsoft.com"
  "diagnostics.support.microsoft.com"
  "e2835.dspb.akamaiedge.net"
  "e7341.g.akamaiedge.net"
  "e7502.ce.akamaiedge.net"
  "e8218.ce.akamaiedge.net"
  "ec.atdmt.com"
  "fe2.update.microsoft.com.akadns.net"
  "feedback.microsoft-hohm.com"
  "feedback.search.microsoft.com"
  "feedback.windows.com"
  "flex.msn.com"
  "g.msn.com"
  "h1.msn.com"
  "h2.msn.com"
  "hostedocsp.globalsign.com"
  "i1.services.social.microsoft.com"
  "i1.services.social.microsoft.com.nsatc.net"
  #"ipv6.msftncsi.com"                    # Issues may arise where Windows 10 thinks it doesn't have internet
  #"ipv6.msftncsi.com.edgesuite.net"      # Issues may arise where Windows 10 thinks it doesn't have internet
  "lb1.www.ms.akadns.net"
  "live.rads.msn.com"
  "m.adnxs.com"
  "msedge.net"
  #"msftncsi.com"
  "msnbot-65-55-108-23.search.msn.com"
  "msntest.serving-sys.com"
  "oca.telemetry.microsoft.com"
  "oca.telemetry.microsoft.com.nsatc.net"
  "onesettings-db5.metron.live.nsatc.net"
  "pre.footprintpredict.com"
  "preview.msn.com"
  "rad.live.com"
  "rad.msn.com"
  "redir.metaservices.microsoft.com"
  "reports.wes.df.telemetry.microsoft.com"
  "schemas.microsoft.akadns.net"
  "secure.adnxs.com"
  "secure.flashtalking.com"
  "services.wes.df.telemetry.microsoft.com"
  "settings-sandbox.data.microsoft.com"
  #"settings-win.data.microsoft.com"       # may cause issues with Windows Updates
  "sls.update.microsoft.com.akadns.net"
  #"sls.update.microsoft.com.nsatc.net"    # may cause issues with Windows Updates
  "sqm.df.telemetry.microsoft.com"
  "sqm.telemetry.microsoft.com"
  "sqm.telemetry.microsoft.com.nsatc.net"
  "ssw.live.com"
  "static.2mdn.net"
  "statsfe1.ws.microsoft.com"
  "statsfe2.update.microsoft.com.akadns.net"
  "statsfe2.ws.microsoft.com"
  "survey.watson.microsoft.com"
  "telecommand.telemetry.microsoft.com"
  "telecommand.telemetry.microsoft.com.nsatc.net"
  "telemetry.appex.bing.net"
  "telemetry.microsoft.com"
  "telemetry.urs.microsoft.com"
  "vortex-bn2.metron.live.com.nsatc.net"
  "vortex-cy2.metron.live.com.nsatc.net"
  "vortex.data.microsoft.com"
  "vortex-sandbox.data.microsoft.com"
  "vortex-win.data.microsoft.com"
  "cy2.vortex.data.microsoft.com.akadns.net"
  "watson.live.com"
  "watson.microsoft.com"
  "watson.ppe.telemetry.microsoft.com"
  "watson.telemetry.microsoft.com"
  "watson.telemetry.microsoft.com.nsatc.net"
  "wes.df.telemetry.microsoft.com"
  "win10.ipv6.microsoft.com"
  "www.bingads.microsoft.com"
  "www.go.microsoft.akadns.net"
  #"www.msftncsi.com"                         # Issues may arise where Windows 10 thinks it doesn't have internet
  "client.wns.windows.com"
  #"wdcp.microsoft.com"                       # may cause issues with Windows Defender Cloud-based protection
  #"dns.msftncsi.com"                         # This causes Windows to think it doesn't have internet
  #"storeedgefd.dsx.mp.microsoft.com"         # breaks Windows Store
  "wdcpalt.microsoft.com"
  "settings-ssl.xboxlive.com"
  "settings-ssl.xboxlive.com-c.edgekey.net"
  "settings-ssl.xboxlive.com-c.edgekey.net.globalredir.akadns.net"
  "e87.dspb.akamaidege.net"
  "insiderservice.microsoft.com"
  "insiderservice.trafficmanager.net"
  "e3843.g.akamaiedge.net"
  "flightingserviceweurope.cloudapp.net"
  #"sls.update.microsoft.com"                 # may cause issues with Windows Updates
  "static.ads-twitter.com"                    # may cause issues with Twitter login
  "www-google-analytics.l.google.com"
  "p.static.ads-twitter.com"                  # may cause issues with Twitter login
  "hubspot.net.edge.net"
  "e9483.a.akamaiedge.net"

  "www.google-analytics.com"
  "padgead2.googlesyndication.com"
  "mirror1.malwaredomains.com"
  "mirror.cedia.org.ec"
  "stats.g.doubleclick.net"
  "stats.l.doubleclick.net"
  "adservice.google.de"
  "adservice.google.com"
  "googleads.g.doubleclick.net"
  "pagead46.l.doubleclick.net"
  "hubspot.net.edgekey.net"
  "insiderppe.cloudapp.net"                   # Feedback-Hub
  "livetileedge.dsx.mp.microsoft.com"

  # extra
  "fe2.update.microsoft.com.akadns.net"
  "s0.2mdn.net"
  "statsfe2.update.microsoft.com.akadns.net"
  "survey.watson.microsoft.com"
  "view.atdmt.com"
  "watson.microsoft.com"
  "watson.ppe.telemetry.microsoft.com"
  "watson.telemetry.microsoft.com"
  "watson.telemetry.microsoft.com.nsatc.net"
  "wes.df.telemetry.microsoft.com"
  "m.hotmail.com"

  # can cause issues with Skype (#79) or other services (#171)
  "apps.skype.com"
  "c.msn.com"
  # "login.live.com"                  # prevents login to outlook and other live apps
  "pricelist.skype.com"
  "s.gateway.messenger.live.com"
  "ui.skype.com"
)
Write-Output "" | Out-File -Encoding ASCII -Append $hosts_file
foreach ($domain in $domains) {
  if (-Not (Select-String -Path $hosts_file -Pattern $domain)) {
    Write-Output "0.0.0.0 $domain" | Out-File -Encoding ASCII -Append $hosts_file
  }
}

Write-Output "Adding telemetry ips to firewall"
$ips = @(
  # Windows telemetry
  "134.170.30.202"
  "137.116.81.24"
  "157.56.106.189"
  "184.86.53.99"
  "2.22.61.43"
  "2.22.61.66"
  "204.79.197.200"
  "23.218.212.69"
  "65.39.117.230"
  #"65.52.108.33"   # Causes problems with Microsoft Store
  "65.55.108.23"
  "64.4.54.254"

  # NVIDIA telemetry
  #"8.36.80.197"
  #"8.36.80.224"
  #"8.36.80.252"
  #"8.36.113.118"
  #"8.36.113.141"
  #"8.36.80.230"
  #"8.36.80.231"
  #"8.36.113.126"
  #"8.36.80.195"
  #"8.36.80.217"
  #"8.36.80.237"
  #"8.36.80.246"
  #"8.36.113.116"
  #"8.36.113.139"
  #"8.36.80.244"
  #"216.228.121.209"
)
Remove-NetFirewallRule -DisplayName "Block Telemetry IPs" -ErrorAction SilentlyContinue
New-NetFirewallRule -DisplayName "Block Telemetry IPs" -Direction Outbound -Action Block -RemoteAddress ([string[]]$ips)

# Block scheduled telemetry tasks
$tasks = @(
  "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
  "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
  #"\Microsoft\Windows\Application Experience\StartupAppTask"
  "\Microsoft\Windows\Application Experience\PcaPatchDbTask"
)

foreach ($task in $tasks) {
  Disable-ScheduledTask -TaskName $task
}

New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type "DWORD" -Value 1 -Force
Get-ScheduledTask -TaskName "QueueReporting" | Disable-ScheduledTask
Get-ScheduledTask -TaskName Consolidator | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask -TaskName UsbCeip | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask -TaskName DmClient | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask -TaskName DmClientOnScenarioDownload | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask
Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask

#Opt-out nVidia Telemetry
Set-ItemProperty -Path "HKLM:\Software\NVIDIA Corporation\Global\FTS" -Name EnableRID44231 -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\Software\NVIDIA Corporation\Global\FTS" -Name EnableRID64640 -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\Software\NVIDIA Corporation\Global\FTS" -Name EnableRID66610 -Type "DWORD" -Value 0 -Force
New-Item -Path "HKLM:\Software\NVIDIA Corporation\NvControlPanel2\Client" -Force
Set-ItemProperty -Path "HKLM:\Software\NVIDIA Corporation\NvControlPanel2\Client" -Name OptInOrOutPreference -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\NvTelemetryContainer" -Name Start -Type "DWORD" -Value 4 -Force
Set-ItemProperty -Path "HKLM:\Software\NVIDIA Corporation\Global\Startup\SendTelemetryData" -Name 0 -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" -Name "SendTelemetryData" -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\NvTelemetryContainer" -Name "Start" -Type "DWORD" -Value 4 -Force
Stop-Service NvTelemetryContainer
Set-Service NvTelemetryContainer -StartupType Disabled
#Delete NVIDIA residual telemetry files
Remove-Item -Recurse $env:systemdrive\System32\DriverStore\FileRepository\NvTelemetry*.dll
Remove-Item -Recurse "$env:ProgramFiles\NVIDIA Corporation\NvTelemetry" | Out-Null

#Disable Media Player Telemetry
Set-ItemProperty -Path "HKCU:\Software\Microsoft\MediaPlayer\Preferences" -Name "UsageTracking" -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\WindowsMediaPlayer" -Name "PreventCDDVDMetadataRetrieval" -Type "DWORD" -Value 1 -Force
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\WindowsMediaPlayer" -Name "PreventMusicFileMetadataRetrieval" -Type "DWORD" -Value 1 -Force
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\WindowsMediaPlayer" -Name "PreventRadioPresetsRetrieval" -Type "DWORD" -Value 1 -Force
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\WMDRM" -Name "DisableOnline" -Type "DWORD" -Value 1 -Force

#Disable Office Telemetry
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Force
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "DisableTelemetry" -Type "DWORD" -Value 1 -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry" -Name "VerboseLogging" -Type "DWORD" -Value 0 -Force
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar" -Name "EnableCalendarLogging" -Type "DWORD" -Value 0 -Force
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Word\Options" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableLogging" -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\15.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableLogging" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Office\16.0\OSM" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
#Disable Office Telemetry Agent
schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /DISABLE
schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" /DISABLE
schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /DISABLE
schtasks /change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" /DISABLE
#Disable Office Subscription Heartbeat
schtasks /change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /DISABLE
schtasks /change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /DISABLE
#Disable Office feedback
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Force
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Feedback" -Name "Enabled" -Type "DWORD" -Value 0 -Force
#Disable Office Customer Experience Improvement Program
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Force
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\15.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common" -Name "QMEnable" -Type "DWORD" -Value 0 -Force

#Disable Microsoft Office Telemetry
Get-ScheduledTask -TaskName "OfficeTelemetryAgentFallBack2016" | Disable-ScheduledTask
Get-ScheduledTask -TaskName "OfficeTelemetryAgentLogOn2016" | Disable-ScheduledTask
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\osm" -Name "Enablelogging" -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\15.0\osm" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm" -Name "Enablelogging" -Type "DWORD" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm" -Name "EnableUpload" -Type "DWORD" -Value 0 -Force
