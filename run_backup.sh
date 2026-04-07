#!/usr/bin/env bash
set -euo pipefail

# Base directory
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$BASE_DIR/MAINFILE"
BACKUP_ROOT_BASE="$BASE_DIR/versionControl/_checkpoints"
LOG_FILE="$BASE_DIR/versionControl/sampleLog.csv"

# Optional first argument: file path relative to MAINFILE/ (or absolute path)
REQUESTED_SOURCE="${1:-}"

if [ -n "$REQUESTED_SOURCE" ]; then
  if [ -f "$REQUESTED_SOURCE" ]; then
    SOURCE_FILE="$REQUESTED_SOURCE"
  elif [ -f "$SOURCE_DIR/$REQUESTED_SOURCE" ]; then
    SOURCE_FILE="$SOURCE_DIR/$REQUESTED_SOURCE"
  else
    echo "❌ ERROR: Source file not found: $REQUESTED_SOURCE"
    exit 1
  fi
else
  SOURCE_FILE="$(find "$SOURCE_DIR" -maxdepth 1 -type f | sort | head -n 1 || true)"
  if [ -z "$SOURCE_FILE" ]; then
    echo "❌ ERROR: No source file found in $SOURCE_DIR"
    exit 1
  fi
fi

SOURCE_BASENAME="$(basename "$SOURCE_FILE")"
SOURCE_STEM="${SOURCE_BASENAME%.*}"
TARGET_FOLDER="$(echo "$SOURCE_STEM" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9._-]/_/g')"
BACKUP_ROOT="$BACKUP_ROOT_BASE/$TARGET_FOLDER"

NOTE="manual-save"
TIMESTAMP="$(date '+%Y-%m-%d_%H-%M')"
BACKUP_FOLDER="$BACKUP_ROOT/${TIMESTAMP}_${NOTE}"

# Create folders if missing
mkdir -p "$BACKUP_FOLDER"
mkdir -p "$(dirname "$LOG_FILE")"

# Copy file
cp "$SOURCE_FILE" "$BACKUP_FOLDER/$SOURCE_BASENAME"

FILE_COUNT=1
TYPE="incremental backup"
DAY="$(date '+%a')"
BACKUP_DATE="$(date '+%Y-%m-%d')"

if [ ! -f "$LOG_FILE" ]; then
  echo "Creating new log file..."
  echo "Day,Backup date,folder path,No. of files,Type" > "$LOG_FILE"
fi

REL_PATH="./versionControl/_checkpoints/${TARGET_FOLDER}/${TIMESTAMP}_${NOTE}"

# Append log entry
echo "${DAY},${BACKUP_DATE},${REL_PATH},${FILE_COUNT},${TYPE}" >> "$LOG_FILE"

echo "✅ Backup created for: $SOURCE_BASENAME"
echo "📂 Backup folder: $BACKUP_FOLDER"
echo "✅ Log updated: $LOG_FILE"
