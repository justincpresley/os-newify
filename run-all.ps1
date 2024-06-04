Write-Host -NoNewline -ForegroundColor Blue "Blocking Telemetry.."
.\block-telemetry.ps1 *>$null
Write-Host -ForegroundColor Green "        Done!"

Write-Host -NoNewline -ForegroundColor Blue "Disabling Services.."
.\disable-services.ps1 *>$null
Write-Host -ForegroundColor Green "        Done!"

Write-Host -NoNewline -ForegroundColor Blue "Removing Forced Apps.."
.\remove-forced-apps.ps1 *>$null
Write-Host -ForegroundColor Green "      Done!"

Write-Host -NoNewline -ForegroundColor Blue "Removing OneDrive.."
.\remove-onedrive.ps1 *>$null
Write-Host -ForegroundColor Green "         Done!"

Write-Host -NoNewline -ForegroundColor Blue "Making you more Private.."
.\fix-privacy.ps1 *>$null
Write-Host -ForegroundColor Green "   Done!"

Write-Host -NoNewline -ForegroundColor Blue "Optimizing Window Update.."
.\optimize-updating.ps1 *>$null
Write-Host -ForegroundColor Green "  Done!"

Write-Host -NoNewline -ForegroundColor Blue "Optimizing User Interface.."
.\optimize-userface.ps1 *>$null
Write-Host -ForegroundColor Green " Done!"

Write-Host -NoNewline -ForegroundColor Blue "Cleaning DNS Data.."
.\dns-data.ps1 *>$null
Write-Host -ForegroundColor Green "         Done!"

Write-Host -NoNewline -ForegroundColor Blue "Purging Temps.."
.\clean-temp.ps1 *>$null
Write-Host -ForegroundColor Green "             Done!"