Invoke-WebRequest -Uri (irm https://api.github.com/repos/glzr-io/glazewm/releases/latest).assets.browser_download_url[-1] -OutFile glazewm-x64.msi
Start-Process -FilePath glazewm-x64.msi -ArgumentList /quiet -Wait

New-Item -Path "$Home\.glzr\glazewm\config.yaml" -Value (irm https://pastebin.com/raw/78Smt1w0) -Force | Out-Null
Move-Item -Path Microsoft-Edge-WebView\vcruntime140.dll -Destination $Env:SystemRoot

$Path = Resolve-Path -Path "$Env:ProgramFiles (x86)\Microsoft\Edge\Application\*\Installer\setup.exe" | Select-Object -Last 1
Start-Process -FilePath $Path -ArgumentList '--uninstall --system-level --force-uninstall --delete-profile' -Wait

$Path = Resolve-Path -Path "$Env:ProgramFiles (x86)\Microsoft\EdgeWebView\Application\*\Installer\setup.exe" | Select-Object -Last 1
Start-Process -FilePath $Path -ArgumentList '--uninstall --system-level --force-uninstall --msedgewebview' -Wait

$Sid = (Get-LocalUser $Env:UserName).Sid.Value
$Package = (Get-AppxPackage Microsoft.SecHealthUI).PackageFullName

New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\$Sid\$Package" -Force
Remove-AppxPackage -Package $Package

Dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart
Dism /Online /Disable-Feature /FeatureName:Microsoft-RemoteDesktopConnection /NoRestart
Dism /Online /Remove-Capability /CapabilityName:Microsoft.Windows.SnippingTool~~~~0.0.1.0 /NoRestart
Dism /Online /Remove-Capability /CapabilityName:Microsoft.Windows.MSPaint~~~~0.0.1.0 /NoRestart
Dism /Online /Remove-Capability /CapabilityName:Microsoft.Windows.Notepad~~~~0.0.1.0 /NoRestart

Remove-Item -Path "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk"
Remove-Item -Path "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\Calculator.lnk"
Remove-Item -Path "$Env:ProgramData\Microsoft\Windows\Start Menu\Programs\GlazeWM.lnk"
Remove-Item -Path "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Accessibility" -Recurse -Force
Remove-Item -Path "$Env:AppData\Microsoft\Windows\Start Menu\Programs\Administrative Tools.lnk"
Remove-Item -Path "$Env:AppData\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk"
Remove-Item -Path "$Home\Desktop\Microsoft Edge.lnk"
