#!/usr/bin/env bash
set -e

# Base directory
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

SOURCE_FILE="$BASE_DIR/MAINFILE/mainFile2.xlsx"
BACKUP_ROOT="$BASE_DIR/versionControl/_checkpoints/mainFile2"
LOG_FILE="$BASE_DIR/versionControl/sampleLog.csv"

NOTE="manual-save"
TIMESTAMP="$(date '+%Y-%m-%d_%H-%M')"

BACKUP_FOLDER="$BACKUP_ROOT/${TIMESTAMP}_${NOTE}"

# Create folders if missing
mkdir -p "$BACKUP_ROOT"
mkdir -p "$BACKUP_FOLDER"
mkdir -p "$(dirname "$LOG_FILE")"

# Copy file
cp "$SOURCE_FILE" "$BACKUP_FOLDER/"

FILE_COUNT=1
TYPE="incremental backup"
DAY="$(date '+%a')"
BACKUP_DATE="$(date '+%Y-%m-%d')"

# 🔥 CREATE CSV FILE IF NOT EXISTS
if [ ! -f "$LOG_FILE" ]; then
  echo "Creating new log file..."
  echo "Day,Backup date,folder path,No. of files,Type" > "$LOG_FILE"
fi

# RELATIVE PATH (IMPORTANT)
REL_PATH="./versionControl/_checkpoints/mainFile2/${TIMESTAMP}_${NOTE}"

# Append log entry
echo "${DAY},${BACKUP_DATE},${REL_PATH},${FILE_COUNT},${TYPE}" >> "$LOG_FILE"

echo "✅ Backup created at: $BACKUP_FOLDER"
echo "✅ Log updated: $LOG_FILE"
