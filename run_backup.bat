@echo off
setlocal enabledelayedexpansion

REM ==============================
REM Get base directory
REM ==============================
set BASE_DIR=%~dp0

REM Remove trailing backslash (important for consistency)
if "%BASE_DIR:~-1%"=="\" set BASE_DIR=%BASE_DIR:~0,-1%

REM ==============================
REM Paths (RELATIVE STRUCTURE)
REM ==============================
set SOURCE_FILE=%BASE_DIR%\MAINFILE\mainFile2.xlsx
set BACKUP_ROOT=%BASE_DIR%\versionControl\_checkpoints\mainFile2
set LOG_FILE=%BASE_DIR%\versionControl\sampleLog.csv

REM ==============================
REM Timestamp (via PowerShell)
REM ==============================
for /f %%i in ('powershell -command "Get-Date -Format yyyy-MM-dd_HH-mm"') do set TIMESTAMP=%%i

set NOTE=manual-save
set BACKUP_FOLDER=%BACKUP_ROOT%\%TIMESTAMP%_%NOTE%

REM ==============================
REM Create directories if missing
REM ==============================
if not exist "%BACKUP_ROOT%" mkdir "%BACKUP_ROOT%"
if not exist "%BACKUP_FOLDER%" mkdir "%BACKUP_FOLDER%"
if not exist "%BASE_DIR%\versionControl" mkdir "%BASE_DIR%\versionControl"

REM ==============================
REM Check source file exists
REM ==============================
if not exist "%SOURCE_FILE%" (
    echo ❌ ERROR: Source file not found!
    echo Expected: %SOURCE_FILE%
    pause
    exit /b
)

REM ==============================
REM Copy file
REM ==============================
copy "%SOURCE_FILE%" "%BACKUP_FOLDER%\" >nul

REM ==============================
REM Metadata
REM ==============================
set FILE_COUNT=1
set TYPE=incremental backup

for /f %%i in ('powershell -command "Get-Date -Format ddd"') do set DAY=%%i
for /f %%i in ('powershell -command "Get-Date -Format yyyy-MM-dd"') do set BACKUP_DATE=%%i

REM ==============================
REM Create CSV if not exists
REM ==============================
if not exist "%LOG_FILE%" (
    echo Creating new log file...
    echo Day,Backup date,folder path,No. of files,Type > "%LOG_FILE%"
)

REM ==============================
REM RELATIVE PATH (IMPORTANT)
REM ==============================
set REL_PATH=./versionControl/_checkpoints/mainFile2/%TIMESTAMP%_%NOTE%

REM ==============================
REM Append log entry
REM ==============================
echo %DAY%,%BACKUP_DATE%,%REL_PATH%,%FILE_COUNT%,%TYPE% >> "%LOG_FILE%"

REM ==============================
REM Done
REM ==============================
echo.
echo ✅ Backup created successfully!
echo 📂 Location: %BACKUP_FOLDER%
echo 📄 Log updated: %LOG_FILE%
echo.

pause
