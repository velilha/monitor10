# Otimizar.ps1
$log = "C:\Users\runneradmin\Desktop\Otimizacao_Log.txt"
"Iniciando otimização: $(Get-Date)" | Out-File $log

# 1. Serviços para desativar
$servicos = @("wuauserv", "bits", "dosvc", "UsoSvc", "WSearch", "bthserv", "BthAvctpSvc", "Spooler", "DiagTrack", "FeedbackHub", "MapsBroker", "dmwappushservice", "RetailDemo", "lfsvc", "stisvc")
foreach ($s in $servicos) {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
}

# 2. Windows Update via Registro
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f

"Otimização concluída: $(Get-Date)" | Out-File $log -Append
