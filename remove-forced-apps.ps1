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

Write-Output "Prepping"
$Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"
If (Test-Path $Holo) {
  Set-ItemProperty $Holo  FirstRunSucceeded -Value 0
}

Write-Output "Uninstalling default apps"
$apps = @(
  # default Windows 10 apps
  "Microsoft.549981C3F5F10" #Cortana
  "Microsoft.3DBuilder"
  "Microsoft.Appconnector"
  "Microsoft.BingFinance"
  "Microsoft.BingNews"
  "Microsoft.BingSports"
  "Microsoft.BingTranslator"
  "Microsoft.BingWeather"
  "Microsoft.FreshPaint"
  "Microsoft.GamingServices"
  "Microsoft.MicrosoftOfficeHub"
  "Microsoft.MicrosoftPowerBIForWindows"
  "Microsoft.MicrosoftSolitaireCollection"
  "Microsoft.MicrosoftStickyNotes"
  "Microsoft.MinecraftUWP"
  "Microsoft.NetworkSpeedTest"
  "Microsoft.Office.OneNote"
  "Microsoft.Office.Todo.List"
  "Microsoft.Office.Lens"
  "Microsoft.People"
  "Microsoft.Print3D"
  "Microsoft.RemoteDesktop"
  "Microsoft.SkypeApp"
  "Microsoft.Wallet"
  #"Microsoft.Windows.Photos"
  #"Microsoft.WindowsAlarms"
  #"Microsoft.WindowsCalculator"
  #"Microsoft.WindowsCamera"
  "Microsoft.Whiteboard"
  "microsoft.windowscommunicationsapps"
  "Microsoft.WindowsMaps"
  "Microsoft.WindowsPhone"
  "Microsoft.WindowsSoundRecorder"
  #"Microsoft.WindowsStore"   # can't be re-installed
  "Microsoft.Xbox.TCUI"
  "Microsoft.XboxApp"
  "Microsoft.XboxIdentityProvider"
  "Microsoft.XboxSpeechToTextOverlay"
  "Microsoft.XboxGameCallableUI"
  "Microsoft.YourPhone"
  "Microsoft.ZuneMusic"
  "Microsoft.ZuneVideo"

  # Threshold 2 apps
  "Microsoft.CommsPhone"
  "Microsoft.ConnectivityStore"
  "Microsoft.GetHelp"
  "Microsoft.Getstarted"
  "Microsoft.Messaging"
  "Microsoft.Office.Sway"
  "Microsoft.OneConnect"
  "Microsoft.WindowsFeedbackHub"
  "Microsoft.BioEnrollment"
  "Windows.ContactSupport"
  "Microsoft.WindowsFeedback"

  # Creators Update apps
  "Microsoft.Microsoft3DViewer"
  "Microsoft.MSPaint"

  # Redstone apps
  "Microsoft.BingFoodAndDrink"
  "Microsoft.BingHealthAndFitness"
  "Microsoft.BingTravel"
  "Microsoft.WindowsReadingList"

  # Redstone 5 apps
  "Microsoft.MixedReality.Portal"
  #"Microsoft.ScreenSketch"
  #"Microsoft.XboxGamingOverlay"

  #Windows 11 Additions
  "Microsoft.Todos"
  "MicrosoftCorporationII.QuickAssist"
  "MicrosoftCorporationII.MicrosoftFamily"
  "MicrosoftTeams"
  "Windows.DevHome"

  # non-Microsoft
  "2FE3CB00.PicsArt-PhotoStudio"
  "46928bounde.EclipseManager"
  "4DF9E0F8.Netflix"
  "613EBCEA.PolarrPhotoEditorAcademicEdition"
  "6Wunderkinder.Wunderlist"
  "7EE7776C.LinkedInforWindows"
  "89006A2E.AutodeskSketchBook"
  "9E2F88E3.Twitter"
  "A278AB0D.DisneyMagicKingdoms"
  "A278AB0D.MarchofEmpires"
  "ActiproSoftwareLLC.562882FEEB491"
  "CAF9E577.Plex"
  "ClearChannelRadioDigital.iHeartRadio"
  "D52A8D61.FarmVille2CountryEscape"
  "D5EA27B7.Duolingo-LearnLanguagesforFree"
  "DB6EA5DB.CyberLinkMediaSuiteEssentials"
  #"DolbyLaboratories.DolbyAccess"
  "Drawboard.DrawboardPDF"
  "Facebook.Facebook"
  "Fitbit.FitbitCoach"
  "Flipboard.Flipboard"
  "GAMELOFTSA.Asphalt8Airborne"
  "KeeperSecurityInc.Keeper"
  "NORDCURRENT.COOKINGFEVER"
  "PandoraMediaInc.29680B314EFC2"
  "Playtika.CaesarsSlotsFreeCasino"
  "ShazamEntertainmentLtd.Shazam"
  "SlingTVLLC.SlingTV"
  #"SpotifyAB.SpotifyMusic"
  "TheNewYorkTimes.NYTCrossword"
  "ThumbmunkeysLtd.PhototasticCollage"
  "TuneIn.TuneInRadio"
  "WinZipComputing.WinZipUniversal"
  "XINGAG.XING"
  "flaregamesGmbH.RoyalRevolt2"
  "king.com.*"
  "king.com.BubbleWitch3Saga"
  "king.com.CandyCrushSaga"
  "king.com.CandyCrushSodaSaga"
  "A025C540.Yandex.Music"
  "Disney.37853FC22B2CE"
  "BytedancePte.Ltd.TikTok"
  "AdobeSystemsIncorporated.AdobeCreativeCloudExpress"
  "AmazonVideo.PrimeVideo"
  "Clipchamp.Clipchamp"
  "FACEBOOK.317180B0BB486"
  "Facebook.InstagramBeta"
  "5319275A.WhatsAppDesktop"
  "5319275A.51895FA4EA97F"
  "26720RandomSaladGamesLLC.*"
  "26720RandomSaladGamesLLC.HeartsDeluxe"
  "26720RandomSaladGamesLLC.SimpleSolitaire"
  "26720RandomSaladGamesLLC.SimpleSpiderSolitaire"
  "26720RandomSaladGamesLLC.Spades"

  # apps which cannot be removed using Remove-AppxPackage
  #"Microsoft.MicrosoftEdge"
  #"Microsoft.Windows.Cortana"

  # apps which other apps depend on
  "Microsoft.Advertising.Xaml"
  "*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*"
  "*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*"
)

foreach ($app in $apps) {
  Write-Output "Trying to remove $app"

  Get-AppxPackage -Name $app -AllUsers |
    Remove-AppxPackage -AllUsers -ErrorAction Continue

  Get-AppXProvisionedPackage -Online |
    Where-Object DisplayName -EQ $app |
    Remove-AppxProvisionedPackage -Online
}

#Uninstall more stuff using WinGet
winget uninstall 9NFTCH6J7FHV #Power Automate
winget uninstall 9NZBF4GT040C #Web Search from Microsoft Bing
winget uninstall 9NTXGKQ8P7N0 #Cross Device Experience Host
winget uninstall 9WZDNCRFJBD8 #Xbox Console Companion
winget uninstall 9WZDNCRFJ0PK #Dropbox Lite
winget uninstall 9NBLGGH537BP #Apps Explorer
winget uninstall 9N12Z3CCTCNZ #Alexa
winget uninstall 9WZDNCRFJ3MB #Evernote
winget uninstall 9WZDNCRFJ3WL #Hearts Deluxe
winget uninstall 9WZDNCRDKRDS #Simple Mahjong
winget uninstall 9WZDNCRFJ3TT #Simple Solitaire
winget uninstall 9WZDNCRDKRDT #Simple Spider Solitaire
winget uninstall 9WZDNCRFJ3GM #Spades
winget uninstall 9NKSQGP7F2NH #WhatsApp
#winget uninstall 9NCBCSZSJRSB #Spotify
winget uninstall 9P1J8S7CCWWT #ClipChamp
winget uninstall 9WZDNCRFJ4Q7 #Linkedin
winget uninstall 9N8MHTPHNGVV #Dev Home
winget uninstall 9NZCC27PR6N6 #Dev Home Github Extension
winget uninstall 9P7JQGL6GC8P #Luminar Neo AI Photo Editor
winget uninstall 9PL59F1G4XSZ #Linkedin
winget uninstall 9PGM3QB3PDRD #Camo Studio
winget uninstall XPDDXX9QW8N9D7 #Grammarly
winget uninstall Microsoft.Teams

Write-Output "Removing Cortana for the Current User"
Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage #Cortana

# Prevents Apps from re-installing
$cdm = @(
  "ContentDeliveryAllowed"
  "FeatureManagementEnabled"
  "FeatureManagementAllowed"
  "OemPreInstalledAppsEnabled"
  "PreInstalledAppsEnabled"
  "PreInstalledAppsEverEnabled"
  "SilentInstalledAppsEnabled"
  "SubscribedContent-314559Enabled"
  "SubscribedContent-338387Enabled"
  "SubscribedContent-338388Enabled"
  "SubscribedContent-338389Enabled"
  "SubscribedContent-338393Enabled"
  "SubscribedContentEnabled"
  "SystemPaneSuggestionsEnabled"
)

New-FolderForced -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
foreach ($key in $cdm) {
  Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" $key 0
}

New-FolderForced -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore" "AutoDownload" 2

# Prevents "Suggested Applications" returning
New-FolderForced -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1

# Disable Prefetch
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d "0" /f
# Disable (Edge) Prelaunch
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v AllowPrelaunch /t REG_DWORD /d "0" /f