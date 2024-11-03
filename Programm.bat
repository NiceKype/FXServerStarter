@echo off

REM Konfigurationsdatei einlesen
for /F "tokens=1,2 delims==" %%A in (config.ini) do (
    set %%A=%%B
)

REM Entferne die Anführungszeichen aus dem Pfad
set serverPath=%serverPath:"=%

REM Fenstertitel
Title "%windowTitle%"

REM Standardwert für txAdminPort setzen, falls in der Config nichts angegeben wurde
if "%txAdminPort%"=="" set txAdminPort=40120

REM Existiert ein Serverpfad in der Config?
if "%serverPath%"=="" (
    color 04
    echo.
    @REM echo FEHLER: Der Pfad zur FXServer.exe muss in der Konfigurationsdatei angegeben werden.
    echo ERROR: The path to the FXServer.exe have to be set in the config file.
    echo.
    pause
    exit /b
)

REM Prüfe ob Serverpfad ist default
if "%serverPath%"=="Path/to/FXServer.exe" (
    color 04
    echo.
    @REM echo FEHLER: Der Pfad zur FXServer.exe wurde nicht eingestellt. Mit dem default Pfad funktioniert das starten nicht.
    echo ERROR: The path to the FXServer.exe wasn't set. With the default path the starting don't work.
    echo.
    pause
    exit /b
)

REM Prüfe ob Pfad auf FXServer.exe endet
if "%serverPath:~-12%" == "FXServer.exe" (
    REM Prüfe ob FXServer.exe in dem angegebenen Pfad existiert
    if not exist "%serverPath%" (
        color 04
        echo.
        @REM echo FEHLER: In dem angegebenen Pfad existiert keine FXServer.exe
        echo ERROR: FXServer.exe does not exist in the specified path.
        echo.
        pause
        exit /b
    )
) else (
    color 04
    echo.
    @REM echo FEHLER: Der Pfad muss zur FXServer.exe führen.
    echo ERROR: The path must lead to the FXServer.exe.
    echo.
    pause
    exit /b
)

REM Aufbau des Startbefehls basierend auf enableProfile
if /I "%enableProfile%"=="true" (
    REM Profile aktivieren, wenn enableProfile auf true steht
    "%serverPath%" +set serverProfile "%profile%" +set txAdminPort "%txAdminPort%"
) else (
    REM Standardbefehl ohne Profil
    "%serverPath%" +set txAdminPort "%txAdminPort%"
)

pause
