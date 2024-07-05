$services = @(
  "diagnosticshub.standardcollector.service"  # Microsoft (R) Diagnostics Hub Standard Collector Service
  "DiagTrack"                                 # Diagnostics Tracking Service
  "dmwappushservice"                          # WAP Push Message Routing Service
  "lfsvc"                                     # Geolocation Service
  "MapsBroker"                                # Downloaded Maps Manager
  "NetTcpPortSharing"                         # Net.Tcp Port Sharing Service
  "RemoteAccess"                              # Routing and Remote Access
  "RemoteRegistry"                            # Remote Registry
  #"SharedAccess"                              # Internet Connection Sharing (ICS)
  "TrkWks"                                    # Distributed Link Tracking Client
  #"WbioSrvc"                                  # Windows Biometric Service (Fingerprint / Facial detection)
  #"WlanSvc"                                   # WLAN AutoConfig
  "WMPNetworkSvc"                             # Windows Media Player Network Sharing Service
  #"wscsvc"                                    # Windows Security Center Service
  "WSearch"                                   # Windows Search
  "XblAuthManager"                            # Xbox Live Auth Manager
  "XblGameSave"                               # Xbox Live Game Save Service
  "XboxNetApiSvc"                             # Xbox Live Networking Service
  "XboxGipSvc"                                # Xbox Accessory Management Service
  "ndu"                                       # Windows Network Data Usage Monitor
  "WerSvc"                                    # Windows Error Reporting
  "Spooler"                                   # Printer
  "Fax"                                       # Fax
  "fhsvc"                                     # Fax Histroy
  "gupdate"                                   # Google Update
  "gupdatem"                                  # Another Google Update
  "stisvc"                                    # Windows Image Acquisition (WIA)
  "AJRouter"                                  # AllJoyn Router Service
  "MSDTC"                                     # Distributed Transaction Coordinator
  "WpcMonSvc"                                 # Parental Controls
  "PhoneSvc"                                  # Phone Service (telephony state)
  "PrintNotify"                               # Windows printer notifications and extentions
  "PcaSvc"                                    # Program Compatibility Assistant Service
  "WPDBusEnum"                                # Portable Device Enumerator Service
  #"LicenseManager"                            # LicenseManager (Store may not work)
  #"seclogon"                                  # Secondary Logon (anything other than password)
  "SysMain"                                   # Sysmain
  "lmhosts"                                   # TCP/IP NetBIOS Helper
  "wisvc"                                     # Windows Insider program (Windows Insider)
  "FontCache"                                 # Windows font cache
  "RetailDemo"                                # RetailDemo (showcasing your device)
  "ALG"                                       # Application Layer Gateway Service (Support for 3rd party protocol plug-ins for Internet Connection Sharing)
  #"BFE"                                       # Base Filtering Engine (BFE) (manages firewall and Internet Protocol security)
  #"BrokerInfrastructure"                      # Windows infrastructure service that controls which background tasks can run on the system.
  "SCardSvr"                                  # Windows Smart Card
  "BthAvctpSvc"                               # AVCTP service (if Bluetooth Audio Device or Wireless Headphones. then don't disable this)
  #"FrameServer"                               # Windows Camera Frame Server (multiple clients to access video frames from camera devices)
  "BthAvctpSvc"                               # AVCTP service (Audio Video Control Transport Protocol service)
  "BDESVC"                                    # Bitlocker
  #"iphlpsvc"                                  # Ipv6 (most websites don't use ipv6)
  "edgeupdate"                                # Edge Update Service  
  "MicrosoftEdgeElevationService"             # Edge Service 
  "edgeupdatem"                               # Edge Update Service                          
  "SEMgrSvc"                                  # Payments and NFC/SE Manager (Manages payments and Near Field Communication (NFC) based secure elements)
  "PerfHost"                                  # Remote users and 64-bit processes to query performance
  "BcastDVRUserService_48486de"               # GameDVR and Broadcast (used for Game Recordings and Live Broadcasts)
  "WpnService"                                # WpnService (Push Notifications may not work )
  #"StorSvc"                                   # StorSvc (usb external hard drive will not be recongized)
  #"RtkBtManServ"                              # Realtek Bluetooth Device Manager Service
  "HvHost"                          
  "vmickvpexchange"
  "vmicguestinterface"
  "vmicshutdown"
  "vmicheartbeat"
  "vmicvmsession"
  "vmicrdv"
  "vmictimesync" 
  #"WdNisSvc"                                  # Can not be removed
  #"Browser"                                   # Computer Browser, Cant not be removed
  #"EntAppSvc"                                 # Enterprise Application Management, Non-exist if Personal Use
)

foreach ($service in $services) {
  Write-Host "Setting $service StartupType to disabled"
  Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Disabled

  $running = Get-Service -Name $service -ErrorAction SilentlyContinue | Where-Object {$_.Status -eq 'Running'}
  if ($running) { 
      Write-Host "Stopping $service"
      Stop-Service -Name $service
  }
}

# Windows Biometric Service (required for Fingerprint reader / facial detection)
Get-Service -Name "WbioSrvc" | Set-Service -StartupType Automatic
