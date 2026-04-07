@echo off
setlocal enabledelayedexpansion

REM ==============================
REM Get base directory
REM ==============================
set BASE_DIR=%~dp0
if "%BASE_DIR:~-1%"=="\" set BASE_DIR=%BASE_DIR:~0,-1%

set SOURCE_DIR=%BASE_DIR%\MAINFILE
set BACKUP_ROOT_BASE=%BASE_DIR%\versionControl\_checkpoints
set LOG_FILE=%BASE_DIR%\versionControl\sampleLog.csv

REM Optional argument: source file path (absolute or relative to MAINFILE)
set REQUESTED_SOURCE=%~1
set SOURCE_FILE=

if not "%REQUESTED_SOURCE%"=="" (
    if exist "%REQUESTED_SOURCE%" (
        set SOURCE_FILE=%REQUESTED_SOURCE%
    ) else if exist "%SOURCE_DIR%\%REQUESTED_SOURCE%" (
        set SOURCE_FILE=%SOURCE_DIR%\%REQUESTED_SOURCE%
    ) else (
        echo ❌ ERROR: Source file not found: %REQUESTED_SOURCE%
        pause
        exit /b 1
    )
) else (
    for /f "delims=" %%f in ('dir /b /a:-d "%SOURCE_DIR%" 2^>nul') do (
        if not defined SOURCE_FILE set SOURCE_FILE=%SOURCE_DIR%\%%f
    )
    if not defined SOURCE_FILE (
        echo ❌ ERROR: No source file found in %SOURCE_DIR%
        pause
        exit /b 1
    )
)

for %%F in ("%SOURCE_FILE%") do (
    set SOURCE_BASENAME=%%~nxF
    set SOURCE_STEM=%%~nF
)

set TARGET_FOLDER=!SOURCE_STEM!
set TARGET_FOLDER=!TARGET_FOLDER: =_!
set TARGET_FOLDER=!TARGET_FOLDER:(=_!
set TARGET_FOLDER=!TARGET_FOLDER:)=_!
set TARGET_FOLDER=!TARGET_FOLDER:[=_!
set TARGET_FOLDER=!TARGET_FOLDER:]=_!
set TARGET_FOLDER=!TARGET_FOLDER:{=_!
set TARGET_FOLDER=!TARGET_FOLDER:}=_!
set TARGET_FOLDER=!TARGET_FOLDER:^!=_!
set TARGET_FOLDER=!TARGET_FOLDER:;=_!
set TARGET_FOLDER=!TARGET_FOLDER:,=_!
set TARGET_FOLDER=!TARGET_FOLDER:.=_!

set BACKUP_ROOT=%BACKUP_ROOT_BASE%\!TARGET_FOLDER!

for /f %%i in ('powershell -command "Get-Date -Format yyyy-MM-dd_HH-mm"') do set TIMESTAMP=%%i
set NOTE=manual-save
set BACKUP_FOLDER=%BACKUP_ROOT%\%TIMESTAMP%_%NOTE%

if not exist "%BACKUP_ROOT%" mkdir "%BACKUP_ROOT%"
if not exist "%BACKUP_FOLDER%" mkdir "%BACKUP_FOLDER%"
if not exist "%BASE_DIR%\versionControl" mkdir "%BASE_DIR%\versionControl"

copy "%SOURCE_FILE%" "%BACKUP_FOLDER%\%SOURCE_BASENAME%" >nul

set FILE_COUNT=1
set TYPE=incremental backup

for /f %%i in ('powershell -command "Get-Date -Format ddd"') do set DAY=%%i
for /f %%i in ('powershell -command "Get-Date -Format yyyy-MM-dd"') do set BACKUP_DATE=%%i

if not exist "%LOG_FILE%" (
    echo Creating new log file...
    echo Day,Backup date,folder path,No. of files,Type > "%LOG_FILE%"
)

set REL_PATH=./versionControl/_checkpoints/!TARGET_FOLDER!/%TIMESTAMP%_%NOTE%

echo %DAY%,%BACKUP_DATE%,%REL_PATH%,%FILE_COUNT%,%TYPE% >> "%LOG_FILE%"

echo.
echo ✅ Backup created for: %SOURCE_BASENAME%
echo 📂 Location: %BACKUP_FOLDER%
echo 📄 Log updated: %LOG_FILE%
echo.

pause
