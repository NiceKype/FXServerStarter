::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCiDJGyX8VAjFC9dQQvCEmK5A54F+O3H3+OEtlgPUfEDVYrS1LHOAukf7kD2Sbgk1X9xgdsJMDVzPjSieAoZ6UpHoHeAJdGZoTPRWEeN80gkCFlHk2LCmGsLctxviMIO3hy3/0Lx0awT3hg=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaH2Q=
::ZQ05rAF9IBncCkqN+0xwdVsFAlTMbws=
::ZQ05rAF9IAHYFVzEqQIWEChRXhKHLliuB6cI7fqb
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQIWEChRXhKHLliuB6cI7fq75vnHow0OXe8vdIqbyqaBJ/IS5wXwetYp03xTls5MHw9ZbAaiYAh0uW9Qt2mAI8KOoE/nRVrJ/0QlCSVyn3DVnj0+cpMgjtsC1y238g3JmrcD2HfxF+kPG2eh1aMoNcgL+EqgYEyIiqFaTeTvZv3sAiXBJntfmH+DjYpkmsMkUWBhRh0an7h/6in5Udz79WMBLTbVoeLg2xk7aZr6LLcQhA27w3Fcz72wnx0aAXFHCURbThmPADjOEhyBxPzTYg1lqdH+M6duZyk9S/hWDDUMkeUJ+Tuml/siKoiqhySDC9qVEh84IqSlZHyX9Te/Pgs=
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATE2kszLTBNXAHi
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCiDJGyX8VAjFC9dQQvCEmK5A54F+O3H3+OEtlgPUfEDVYrS1LHOAukf7kD2Sbgk1X9xgdsJMDVzPjSieAoZ6UpHoHeAJdGZoTPRWEeN80gkCFlHk2LCmGsLctxviMIO3hyYxH76jbMVw0vrX7saW2b5xMw=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
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