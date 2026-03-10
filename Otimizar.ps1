# Otimizar.ps1
$logPath = "C:\Users\runneradmin\Desktop\Otimizacao_Log.txt"
"Script Iniciado em: $(Get-Date)" | Out-File $logPath

$ErrorActionPreference = "SilentlyContinue"

# 1. Desativa serviços
$servicos = @("wuauserv", "bits", "dosvc", "UsoSvc", "WSearch", "bthserv", "BthAvctpSvc", "Spooler", "DiagTrack", "FeedbackHub")
foreach ($s in $servicos) {
    Stop-Service -Name $s -Force
    Set-Service -Name $s -StartupType Disabled
}

# 2. Otimizações de registro
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f

"Script Finalizado com sucesso em: $(Get-Date)" | Out-File $logPath -Append
