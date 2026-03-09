@echo off
title Otimizador de RAM - Windows 2022
echo [1/2] Desativando Windows Update...
net stop wuauserv /y
sc config wuauserv start= disabled
net stop bits /y
sc config bits start= disabled
net stop usosvc /y
sc config usosvc start= disabled

echo [2/2] Desativando Defender e Telemetria...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
sc config DiagTrack start= disabled
net stop DiagTrack /y

echo.
echo Limpando memoria RAM...
powershell -command "[System.GC]::Collect(); Stop-Service -Name 'SysMain' -Force"

echo Pronto! Otimizacao concluida.
pause
