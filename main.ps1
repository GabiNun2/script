$ProgressPreference = 'SilentlyContinue'

Invoke-RestMethod https://github.com/GabiNun2/script/raw/main/registry.reg -OutFile registry.reg
Start-Process -FilePath regedit.exe -ArgumentList '/s registry.reg'

Invoke-RestMethod https://gist.github.com/GabiNun2/3a43afb560eab5a027d4c2d5dd18e7a6/raw/Install-Winget.ps1 | Invoke-Expression
Invoke-RestMethod https://github.com/GabiNun2/script/raw/main/packages.ps1 | Invoke-Expression | Out-Null

powercfg /hibernate off
powercfg /change standby-timeout-ac 0
powercfg /change monitor-timeout-ac 15

attrib +h "$Home\Saved Games"
attrib +h C:\Windows.old
attrib +h $Env:Public
attrib +h $Home\Videos
attrib +h $Home\Searches
attrib +h $Home\Pictures
attrib +h $Home\Music
attrib +h $Home\Links
attrib +h $Home\Favorites
attrib +h $Home\Documents
attrib +h $Home\Contacts
attrib -h $Home\AppData
attrib +h $Home\.glzr

Set-Service -Name UsoSvc -StartupType Disabled
Set-TimeZone -Id "Israel Standard Time"

Remove-Item -Path registry.reg
Stop-Process -Name explorer
