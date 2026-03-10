# Otimizar.ps1
$log = "C:\Otimizacao_Log.txt"
"Iniciando otimização em: $(Get-Date)" | Out-File $log

# Lista de serviços
$servicos = @("wuauserv", "bits", "dosvc", "UsoSvc", "WSearch", "bthserv", "BthAvctpSvc", "Spooler", "DiagTrack", "FeedbackHub", "MapsBroker", "dmwappushservice", "RetailDemo", "lfsvc", "stisvc")
foreach ($s in $servicos) {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
}

# Windows Update via Registro
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f

"Otimização finalizada com sucesso em: $(Get-Date)" | Out-File $log -Append
