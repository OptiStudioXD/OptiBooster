@echo off

:: Pedir privilegios de administrador, necesario para ciertas acciones
	IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

:: titulo
title Opti Booster

:: Aplicar el nombre del ejecutable y el titulo del juego
set TITLE=
set EXE=

:: Revisa si el turbo esta configurado, si no, mandenlo al gulag :v
IF [%EXE%] == [] goto ERROR

:: Avisar al usuario que estamos esperando el ejecutable
echo.
echo ===============================================================================
echo                    Opti Booster  - Esperando juego...
echo ===============================================================================
echo.
echo        Tienes que iniciar el juego para ejecutar el OptiCore!
echo       Si tienes fallos, establece el input y el .exe correctamente!
echo.
echo ===============================================================================
echo.

:: Volver si no se encuentra el proceso
:LOOP

:: Buscar el proceso del juego
tasklist | find /i "%EXE%" >nul 2>&1

:: Si el proceso no se encuentra, reiniciar la busqueda, si se encuentra seguir con la optimizacion
IF ERRORLEVEL 1 (
  GOTO LOOP
) ELSE (
  cls
  GOTO CONTINUE
)

:: Ir al apartado de continuar con la optimizacion
:CONTINUE

:: Esperar 15 segundos a que se inicie correctamente el juego
timeout /t 15 /nobreak

:: Estableciendo mayor prioridad al juego y menor a los procesos del sistema
wmic process where name="%EXE%" CALL setpriority "32768"
wmic process where name="explorer.exe" CALL setpriority "64"
wmic process where name="audiodg.exe" CALL setpriority "64"
wmic process where name="csrss.exe" CALL setpriority "64"
wmic process where name="winlogon.exe" CALL setpriority "64"
wmic process where name="dwm.exe" CALL setpriority "64"
wmic process where name="ntoskrnl.exe" CALL setpriority "64"
wmic process where name="WmiPrvSE.exe" CALL setpriority "64"
wmic process where name="MicrosoftEdgeUpdate.exe" CALL setpriority "64"
wmic process where name="lsass.exe" CALL setpriority "64"
wmic process where name="fontdrvhost.exe" CALL setpriority "64"
wmic process where name="conhost.exe" CALL setpriority "64"
wmic process where name="EpicWebHelper.exe" CALL setpriority "64"
wmic process where name="dllhost.exe" CALL setpriority "64"
wmic process where name="ApplicationFrameHost.exe" CALL setpriority "64"
wmic process where name="SecurityHealthService.exe" CALL setpriority "64"
wmic process where name="SearchApp.exe" CALL setpriority "64"
wmic process where name="ShellExperienceHost.exe" CALL setpriority "64"
wmic process where name="StartMenuExperienceHost.exe" CALL setpriority "64"
wmic process where name="rundll32.exe" CALL setpriority "64"
wmic process where name="steam.exe" CALL setpriority "64"
wmic process where name="steamwebhelper.exe" CALL setpriority "64"

:: Apagando servicios innecesarios para jugar
net stop uxsms
net stop SysMain
net stop DiagTrack
net stop Themes
net stop WSEARCH
net stop wuauserv
net stop FontCache
net stop UevAgentService
net stop TabletInputService
net stop ShellHWDetection
net stop shpamsvc
net stop RemoteRegistry
net stop AJRouter
net stop AssignedAccessManagerSvc
net stop MapsBroker
net stop DPS
net stop PcaSvc
net stop shpamsvc
net stop diagsvc
net stop WbioSrvc
net stop WerSvc
net stop WaaSMedicSvc
net stop diagnosticshub.standardcollector.service
net stop sppsvc

:: Cerrando aplicaciones inutiles (como yo)
taskkill /f /im CompatTelRunner.exe
taskkill /f /im OneDrive.exe
taskkill /f /im Dropbox.exe
taskkill /f /im SearchIndexer.exe
taskkill /f /im SearchUI.exe
taskkill /f /im control.exe
taskkill /f /im mmc.exe
taskkill /f /im spoolsv.exe
taskkill /f /im StartMenuExperienceHost.exe
taskkill /f /im taskhostw.exe
taskkill /f /im mscorsvw.exe
taskkill /f /im MicrosoftEdgeUpdate.exe
taskkill /f /im TextInputHost.exe
taskkill /f /im SystemSettings.exe
taskkill /f /im WinStore.App.exe

:: Aplicando optis
regedit /S "Optimization\RAM\Optimizar RAM.reg"
regedit /S "Optimization\RAM\Deshabilitar Compresion.cmd"
regedit /S "Optimization\Telemetry\Deshabilitar Telemetria.reg"
regedit /S "Optimization\Services\Optimizar Servicios.reg"
powercfg -h off >nul 2>&1
powercfg -import "%~dp0Optimization\Energy\OptiGamingMode.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
regedit /S "Optimization\Graficos\Optimizar NVIDIA.reg"
regedit /S "Optimization\Graficos\Optimizar INTEL.reg"

start "" "%~dp0Optimization\Temp\FastTempDel.bat"
timeout /t 2 /nobreak >nul
echo Esperando un tiempo para que se acomode todo...
timeout /t 5 /nobreak >nul

:: Limpiando texto
cls

:: Volver si el proceso sigue corriendo
:WAIT

:: Avisar al usuario que estamos esperando a que se cierre el proceso
echo.
echo ===============================================================================
echo                        Azteca Turbo - Esperando cierre...
echo ===============================================================================
echo.
echo Esperando a que la aplicacion se cierre para restablecer los cambios
echo Si tienes fallos, recuerda establecer el ejecutable y el titulo correctamente!
echo.
echo ===============================================================================
echo.

:: Esperar 10 segundos para evitar una sobrecarga en el procesador
timeout /t 10 /nobreak 

:: Buscar el proceso del juego
tasklist | find /i "%EXE%" >nul 2>&1

:: Si el proceso no se encuentra, ir al apartado de END, si se encuentra seguir como estaba antes
IF ERRORLEVEL 1 (
  GOTO END
) ELSE (
  cls
  GOTO WAIT
)

:: Apartado de Revertir los Cambios
:END

:: Estableciendo la prioridad como antes
wmic process where name="EXPLORER.exe" CALL setpriority "32"
wmic process where name="audiodg.exe" CALL setpriority "32"
wmic process where name="csrss.exe" CALL setpriority "32"
wmic process where name="winlogon.exe" CALL setpriority "32"
wmic process where name="dwm.exe" CALL setpriority "32"
wmic process where name="ntoskrnl.exe" CALL setpriority "32"
wmic process where name="WmiPrvSE.exe" CALL setpriority "32"
wmic process where name="MicrosoftEdgeUpdate.exe" CALL setpriority "32"
wmic process where name="lsass.exe" CALL setpriority "32"
wmic process where name="fontdrvhost.exe" CALL setpriority "32"
wmic process where name="conhost.exe" CALL setpriority "32"
wmic process where name="EpicWebHelper.exe" CALL setpriority "32"
wmic process where name="dllhost.exe" CALL setpriority "32"
wmic process where name="ApplicationFrameHost.exe" CALL setpriority "32"
wmic process where name="SecurityHealthService.exe" CALL setpriority "32"
wmic process where name="SearchApp.exe" CALL setpriority "32"
wmic process where name="ShellExperienceHost.exe" CALL setpriority "32"
wmic process where name="StartMenuExperienceHost.exe" CALL setpriority "32"
wmic process where name="rundll32.exe" CALL setpriority "32"
wmic process where name="steam.exe" CALL setpriority "32"
wmic process where name="steamwebhelper.exe" CALL setpriority "32"

:: Iniciando los servicios
net start uxsms
net start SysMain
net start DiagTrack
net start Themes
net start WSEARCH
net start FontCache
net start UevAgentService
net start TabletInputService
net start ShellHWDetection
net start shpamsvc
net start RemoteRegistry
net start AJRouter
net start AssignedAccessManagerSvc
net start MapsBroker
net start DPS
net start PcaSvc
net start shpamsvc
net start diagsvc
net start WbioSrvc
net start WerSvc
net start diagnosticshub.standardcollector.service
net start sppsvc
exit

:ERROR
mshta vbscript:msgbox("Parece que el turbo no esta bien configurado..                       Te recomiendo leer el archivo 'Ayuda.bat' para que sepas como configurarlo correctamente",16,"Azteca Turbo")(window.close)
exit