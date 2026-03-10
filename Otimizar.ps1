# ==========================================================
# 1. DESATIVAÇÃO IMEDIATA (Performance e Serviços)
# ==========================================================

# Desativar Windows Update, Search, Bluetooth, Impressora
$servicos = @("wuauserv", "bits", "dosvc", "UsoSvc", "WSearch", "bthserv", "BthAvctpSvc", "Spooler", "DiagTrack", "FeedbackHub")
foreach ($s in $servicos) {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
}

# Bloqueios de Registro (Update, Telemetria e Feedback)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 9012038010000000 /f

# ==========================================================
# 2. BOTÃO DE EMERGÊNCIA (Ativar Update)
# ==========================================================
$batPath = "C:\Users\runneradmin\Desktop\AtivarUpdate.bat"
$batContent = @"
@echo off
echo Reativando Windows Update...
sc config wuauserv start= auto
sc start wuauserv
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f /v "NoAutoUpdate"
echo Windows Update reativado!
pause
"@
$batContent | Out-File -FilePath $batPath -Encoding ascii

# ==========================================================
# 3. MUDANÇA DE IDIOMA PARA PORTUGUÊS (BRASIL)
# ==========================================================
# Instala o pacote de idioma pt-BR e define como padrão
$Language = "pt-BR"
Install-Language -Language $Language
Set-WinSystemLocale -SystemLocale $Language
Set-WinHomeLocation -GeoId 32 # Brasil
Set-WinUILanguageOverride -Language $Language
Set-UserLanguageList -LanguageList $Language, "en-US" -Force

# ==========================================================
# FINALIZAÇÃO
# ==========================================================
# Reinicia o Explorer para aplicar todas as mudanças
Stop-Process -Name explorer -Force
