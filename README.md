# Local Checkpoints & Backup Activity Tool

## 2. Overview

This project is a simple, local backup tool for people who do not use Git or command-line workflows.

It helps you create safe checkpoints of your working files, keep a history of backups, and review older versions in a visual dashboard.

It is designed for non-technical users such as accountants, Excel users, and office teams who want a clear and reliable way to save work over time.

Why this tool exists:

- To make backups easy (double-click and done)
- To avoid complex developer tools
- To keep everything local and portable
- To provide a clear history of what was backed up and when

## 3. Key Features

- **Local-first backup system**
  - Your files and backup history stay on your machine.
- **No installation for UI**
  - Open `index.html` directly in any modern browser.
- **Works on Windows and Linux**
  - Includes both `run_backup.bat` and `run_backup.sh`.
- **Double-click backup execution**
  - Easy backup trigger for everyday users.
- **CSV-based backup history**
  - Every backup is logged in `sampleLog.csv`.
- **Backup filtering and search**
  - Quickly find specific backup entries.
- **File-explorer-like preview**
  - View and access previous checkpoint folders.
- **Portable (copy folder → works)**
  - Move the project folder to another location or machine and keep using it.
- **Rename-safe checkpoint history**
  - You can rename your working file and still keep the same checkpoint timeline.

## 4. How It Works

The flow is simple:

1. You run a backup script (`.bat` on Windows or `.sh` on Linux).
2. A new backup folder is created with a timestamp.
3. Your source files are copied into that backup folder.
4. The CSV log is updated with a new entry.
5. The web dashboard (`index.html`) reads the CSV and shows your backup history.

In short: **User runs script → backup created → CSV updated → HTML reads CSV**.

## 5. Setup Instructions

1. Download or copy the full `versionControl/` folder to your computer.
2. No installation is required for the web interface.
3. Python is **not** required.
4. Backup scripts are already included and ready to use.

## 6. How to Create a Backup

### Windows

Double-click:

`run_backup.bat`

### Linux

Run:

```bash
./run_backup.sh
```

What happens automatically:

- A new timestamped backup folder is created
- Files are copied from `MAINFILE/`
- The CSV log is updated with backup details

## 7. How to Use the Web App

1. Open `index.html` in your browser.
2. Go to the **Backup Log** tab.
3. Load the CSV log file (or use auto-load if available).
4. View the list of backups.
5. Use filters/search to narrow results.
6. Click a row to preview that backup.
7. Use actions such as:
   - **Open Folder**
   - **Copy Path**

## 8. CSV Log Format

Example columns:

`Day,Backup date,folder path,No. of files,Type`

What each column means:

- **Day**: Weekday name for the backup (for example, Monday)
- **Backup date**: Date/time when the backup was created
- **folder path**: Relative path to the checkpoint folder
- **No. of files**: Number of files copied in that backup
- **Type**: Backup label/category (if used by your workflow)

## 9. Folder Structure Explanation

```text
versionControl/
├─ index.html
├─ README.md
├─ run_backup.bat
├─ run_backup.sh
├─ MAINFILE/
└─ versionControl/
   ├─ sampleLog.csv
   └─ _checkpoints/
      └─ targets/
         └─ <targetId>/
            ├─ meta.json
            └─ versions/
               └─ <timestamp_note>/
                  ├─ <saved-file>
                  └─ version.json
```

Simple explanation:

- **MAINFILE/**
  - Your original working files (source files to back up).
- **versionControl/_checkpoints/**
  - Stores checkpoint history. Each tracked file uses a stable internal target ID.
- **versionControl/sampleLog.csv**
  - Stores backup history entries used by the dashboard.
- **index.html**
  - Visual dashboard to browse backup activity.
- **run_backup.bat / run_backup.sh**
  - Scripts that create backups and update the log.

## 10. Important Notes

- All paths are relative, so the project is portable.
- No machine-specific absolute paths are required.
- Some browsers may block opening folders directly for security reasons.
- **Copy Path** is the most reliable option when direct folder opening is blocked.
- Backups are created by the scripts, not by the browser page itself.
- Checkpoint history does **not** depend on keeping the same file name.
- If you rename a file (example: `sales.xlsx` → `sales-final.xlsx`), previous checkpoints still stay visible.
- Restore is safe: restoring creates a new `_restored_...` copy and does not overwrite your current original file.

## 11. Create Backup Now Button

- The **Create Backup Now** button is currently a placeholder.
- Browsers cannot reliably run local system scripts directly for security reasons.
- This button is included for possible future integration.

## 12. Cross Platform Support

- Works on **Windows** using `run_backup.bat`
- Works on **Linux** using `run_backup.sh`
- No Python required
- No installation required for the UI

## 13. Limitations

- Browser-based apps cannot always open file explorer reliably.
- Preview behavior may depend on local browser and file permissions.
- Backup creation must be triggered externally through the provided scripts.

## 14. Future Improvements

- Connect **Create Backup Now** directly to backup scripts
- Offer a desktop app version (Electron or Tauri)
- Add automatic backup scheduling
- Improve backup preview and navigation experience

## 15. Conclusion

This tool is a **simple, portable, and safe** way to manage local file backups.

It is built for non-technical users who want clear checkpoint history without Git, setup complexity, or cloud dependency.
