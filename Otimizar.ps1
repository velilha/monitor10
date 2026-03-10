# Otimizar.ps1
# Este script é chamado pelo ExecOtimizacao.vbs que criamos no .yml

# 1. Desativa serviços desnecessários para ganhar performance
$servicos = @("wuauserv", "bits", "dosvc", "UsoSvc", "WSearch", "bthserv", "BthAvctpSvc", "Spooler", "DiagTrack", "FeedbackHub")
foreach ($s in $servicos) {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
}

# 2. Otimizações de registro (Desativa atualizações e limpa busca)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f

# 3. Cria um atalho na Desktop para reativar atualizações se precisar
$batContent = @"
@echo off
sc config wuauserv start= auto
sc start wuauserv
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f /v "NoAutoUpdate"
echo Atualizacoes reativadas!
pause
"@
$batContent | Out-File -FilePath "C:\Users\runneradmin\Desktop\Reativar_Updates.bat" -Encoding ascii

Write-Host "Otimizacao concluida com sucesso!"
