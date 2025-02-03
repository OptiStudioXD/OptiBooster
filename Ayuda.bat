@echo off
title OptiBooster - Instrucciones
color 0A

cls
echo Hola! Bienvenido al OptiBooster!
echo.
echo Este script se dedica a optimizar tu sistema operativo solo al jugar,
echo deshabilitando temporalmente componentes y aplicaciones que reducen el rendimiento.
echo Restaurando todas las optimizaciones al cerrar el mismo.
echo.
echo Para utilizarlo tendras que editar algunos parametros del booster con el objetivo de funcionar correctamente.
echo Tienes que darle click derecho al archivo "OptiBooster.bat" y tocar el boton de editar,
echo cuando lo hagas se te iniciara un bloc de notas con el codigo fuente del optimizador.
echo.
echo Lo que tienes que hacer es ir al apartado de "Aplicar el nombre del ejecutable y el titulo del juego"
echo tambien reconocido como set TITLE= y set EXE=
echo Una vez llegues ahi, vas a editar el apartado de "set TITLE=" y al final del "=" vas a poner el nombre del juego,
echo en mi caso Fifa 16. Quedaria asi:
echo set TITLE=Fifa 16
echo.
echo Ahora, vas a iniciar el juego hasta llegar al menu, luego de eso necesitas iniciar el administrador de tareas 
echo (puedes usar CTRL + SHIFT + ESC) y ve al apartado de procesos, alli tienes que encontrar el nombre 
echo del proceso de tu juego, en mi caso, seria Fifa 16.exe. 
echo Quedaria asi: set EXE=.exe (recuerda siempre poner .exe al final del proceso).
echo.
echo Esto puede variar dependiendo del juego, no siempre el proceso se va a llamar de igual manera que el videojuego,
echo por ejemplo Resident Evil 2 se llama RE2.exe, Silent Hill 2 es sh2pc.exe, Ratatouille es overlay.exe.
echo.
pause
exit
