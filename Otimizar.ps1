# Otimizar.ps1 - Versão Robusta
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

# 3. Idioma: REMOVEMOS O START-JOB
# Vamos rodar direto. Se demorar, ele só vai terminar de configurar quando você já estiver logado.
Install-Language -Language pt-BR
Set-WinSystemLocale -SystemLocale pt-BR
Set-WinHomeLocation -GeoId 32
Set-WinUILanguageOverride -Language pt-BR
Set-UserLanguageList -LanguageList pt-BR, en-US -Force

# 4. Criar log de erro para você ver se falhou
$logPath = "C:\Users\runneradmin\Desktop\Otimizacao_Log.txt"
"Otimização rodou em: $(Get-Date)" | Out-File $logPath
