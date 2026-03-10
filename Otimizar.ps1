# Otimizar.ps1
$log = "C:\Users\runneradmin\Desktop\Otimizacao_Log.txt"
"Iniciando em $(Get-Date)" | Out-File $log

# Apenas desativa serviços (sem mexer no explorer.exe)
$servicos = @("wuauserv", "bits", "dosvc", "UsoSvc", "WSearch")
foreach ($s in $servicos) {
    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
}

"Finalizado em $(Get-Date)" | Out-File $log -Append
