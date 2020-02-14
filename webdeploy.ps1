Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine -Force
Enable-PSRemoting -Force

Install-WindowsFeature Web-Server -IncludeManagementTools
Install-WindowsFeature Web-App-Dev -IncludeAllSubFeature

Set-NetFirewallRule FPS-SMB-In-TCP -Enabled True
Set-NetFirewallRule FPS-ICMP4-ERQ-In -Enabled True
Set-NetFirewallRule FPS-ICMP6-ERQ-In -Enabled True
Set-NetFirewallRule WMI-WINMGMT-In-TCP -Enabled True
Install-PackageProvider -Name NuGet -Force
Install-Module -Name Az -AllowClobber -Force
wmic useraccount where "Name='srvAppPoolCOL'" set PasswordExpires=false
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
$packages = 'urlrewrite', `
            'notepadplusplus',
            '7zip',
            'googlechrome'

foreach ($package in $packages) {
         choco install $package -y -f
}

choco install dotnetcore-windowshosting --version=2.1.14 -y -f