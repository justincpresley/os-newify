$services = @(
  "diagnosticshub.standardcollector.service" # Microsoft (R) Diagnostics Hub Standard Collector Service
  "DiagTrack"                                # Diagnostics Tracking Service
  "dmwappushservice"                         # WAP Push Message Routing Service (see known issues)
  "lfsvc"                                    # Geolocation Service
  "MapsBroker"                               # Downloaded Maps Manager
  "NetTcpPortSharing"                        # Net.Tcp Port Sharing Service
  "RemoteAccess"                             # Routing and Remote Access
  "RemoteRegistry"                           # Remote Registry
  "SharedAccess"                             # Internet Connection Sharing (ICS)
  "TrkWks"                                   # Distributed Link Tracking Client
  #"WlanSvc"                                 # WLAN AutoConfig (Disabling this can cause issues with wifi connectivity)
  "WMPNetworkSvc"                            # Windows Media Player Network Sharing Service
  #"wscsvc"                                  # Windows Security Center Service
  #"WSearch"                                 # Windows Search
  "XblAuthManager"                           # Xbox Live Auth Manager
  "XblGameSave"                              # Xbox Live Game Save Service
  "XboxNetApiSvc"                            # Xbox Live Networking Service
  "ndu"                                      # Windows Network Data Usage Monitor
  # Extras
  "MessagingService"
  "PimIndexMaintenanceSvc"
  "RetailDemo"
  "DoSvc"
  "OneSyncSvc"
  "UnistoreSvc"
  # Services which cannot be disabled
  #"WdNisSvc"
)

foreach ($service in $services) {
  Write-Output "Trying to disable $service"
  Get-Service -Name $service | Stop-Service
  Get-Service -Name $service | Set-Service -StartupType Disabled
}

# Windows Biometric Service (required for Fingerprint reader / facial detection)
Get-Service -Name "WbioSrvc" | Set-Service -StartupType Automatic