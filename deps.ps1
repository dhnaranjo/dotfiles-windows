# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}


### Update Help for Modules
Write-Host "Updating Help..." -ForegroundColor "Yellow"
Update-Help -Force


### Package Providers
Write-Host "Installing Package Providers..." -ForegroundColor "Yellow"
Get-PackageProvider NuGet -Force | Out-Null
# Chocolatey Provider is not ready yet. Use normal Chocolatey
#Get-PackageProvider Chocolatey -Force
#Set-PackageSource -Name chocolatey -Trusted


### Install PowerShell Modules
Write-Host "Installing PowerShell Modules..." -ForegroundColor "Yellow"
Install-Module Posh-Git -Scope CurrentUser -Force
Install-Module PSWindowsUpdate -Scope CurrentUser -Force


### Chocolatey
Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if ((which cinst) -eq $null) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

# system and cli
choco install curl                --limit-output
choco install nuget.commandline   --limit-output
#choco install webpi               --limit-output
choco install git                 --limit-output -params='"/GitAndUnixToolsOnPath /NoShellIntegration"'
#choco install nvm                 --limit-output
#choco install ruby                --limit-output
choco install poshgit             --limit-output

# browsers
choco install GoogleChrome        --limit-output
choco install Firefox             --limit-output

# dev tools and frameworks
choco install visualstudiocode    --limit-output -params='"/NoDesktopIcon /NoContextMenuFiles /NoContextMenuFolders"'
#choco install vim                 --limit-output
choco install docker-for-windows  --limit-output
#choco install yarn                --limit-output --no-dependencies
#choco install elixir              --limit-output

Refresh-Environment

#nvm on
#$nodeLtsVersion = choco search nodejs-lts --limit-output | ConvertFrom-String -TemplateContent "{Name:package-name}\|{Version:1.11.1}" | Select -ExpandProperty "Version"
#nvm install $nodeLtsVersion
#nvm use $nodeLtsVersion
#Remove-Variable nodeLtsVersion

#gem pristine --all --env-shebang

### Windows Features

# Web Platform Installer for remaining Windows features
#webpicmd /Install /AcceptEula /Products:"UrlRewrite2"
#webpicmd /Install /AcceptEula /Products:"NETFramework452"
#webpicmd /Install /AcceptEula /Products:"Python279"

### Node Packages
#Write-Host "Installing Node Packages..." -ForegroundColor "Yellow"
#if (which yarn) {
#}