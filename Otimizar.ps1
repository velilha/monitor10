# Otimizar.ps1
# Mudamos o caminho do log para a raiz C:\ para evitar bloqueios de permissão na Desktop
$log = "C:\Otimizacao_Log.txt"
"Script rodou em: $(Get-Date)" | Out-File $log

# Seus comandos de otimização aqui...
# (Exemplo)
Stop-Service -Name "wuauserv" -Force -ErrorAction SilentlyContinue

"Concluiu em: $(Get-Date)" | Out-File $log -Append
