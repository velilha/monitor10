# Instala idioma e define PT-BR
Install-Language pt-BR
Set-WinSystemLocale -SystemLocale pt-BR
Set-WinUserLanguageList -LanguageList pt-BR -Force
Set-WinUILanguageOverride -Language pt-BR

# Desativa serviços pesados
$servicos = @("wuauserv", "bits", "dosvc", "DiagTrack", "WerSvc", "WbioSrvc", "Spooler", "WSearch", "MapsBroker", "dmwappushservice", "bthserv", "PhoneSvc", "lfsvc")
foreach ($s in $servicos) {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
}

# Otimização visual
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2
