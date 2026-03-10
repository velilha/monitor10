$u = $env:USERNAME
$bp = "C:\Users\$u\Desktop\Ativar.bat"

# Desativa serviços pesados e telemetria
$s = @("wuauserv", "bits", "dosvc", "UsoSvc", "WSearch", "bthserv", "BthAvctpSvc", "Spooler", "DiagTrack", "FeedbackHub")
foreach ($x in $s) {
    Stop-Service -Name $x -Force -ErrorAction SilentlyContinue
    Set-Service -Name $x -StartupType Disabled -ErrorAction SilentlyContinue
}

# Otimizações de registro
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 9012038010000000 /f

# Cria o arquivo de emergência (Ativar.bat)
$bc = @"
@echo off
sc config wuauserv start= auto
sc start wuauserv
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f /v "NoAutoUpdate"
pause
"@
$bc | Out-File -FilePath $bp -Encoding ascii

# Aplica idioma em segundo plano (não trava o sistema)
Start-Job -ScriptBlock {
    Install-Language -Language pt-BR
    Set-WinSystemLocale -SystemLocale pt-BR
    Set-WinHomeLocation -GeoId 32
    Set-WinUILanguageOverride -Language pt-BR
    Set-UserLanguageList -LanguageList pt-BR, en-US -Force
    Stop-Process -Name explorer -Force
}
