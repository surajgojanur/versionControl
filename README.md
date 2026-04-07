# Local Checkpoints & Backup Activity Tool

A simple, visual backup and checkpoint system for everyday users.

---

## 1) Overview

**Local Checkpoints & Backup Activity Tool** is a local-first project that helps you create and track backups of important files and folders without using complex developer tools.

It is designed for non-technical users such as:
- Accountants
- Office teams
- Excel-heavy workflows
- Anyone who wants “save points” for files

### Why this exists

Many users need version history, but do not want to learn Git, command-line workflows, or cloud platforms.
This tool provides a straightforward alternative:
- Make a backup snapshot
- Keep a readable log
- Open a simple dashboard to review history

> ✅ **This is NOT Git.**
>
> It is a **simple, visual backup system** focused on local folders and easy recovery.

---

## 2) Key Features

- **Local-first backup system** (your data stays on your machine)
- **No installation required for UI** (open `index.html` directly)
- **CSV-based backup tracking** (easy to read in Excel)
- **Filterable backup history** in the dashboard
- **File-explorer-like preview** of backup records and paths
- **Portable setup** (copy folder to another machine and keep working)
- **Works on Windows and Linux**

---

## 3) How It Works (Architecture)

The flow is intentionally simple:

**User → `backup_runner.py` → creates backup → updates CSV → `index.html` reads CSV**

### Step-by-step flow

1. You run the Python script (`backup_runner.py`) with a backup name/tag.
2. The script creates a timestamped backup folder in `_checkpoints`.
3. It copies your source files/folders into that backup folder.
4. It adds a new line to `sampleLog.csv` with details about the backup.
5. You open `index.html` to view and filter the backup history.

---

## 4) Installation / Setup

No complex setup is required.

1. **Copy the entire project folder** (`versionControl/`) anywhere you want.
2. **Make sure Python is installed** on your machine.
   - Check with: `python --version`
3. **No web server is needed** for the dashboard.
4. **Open `index.html` in your browser** (double-click or open manually).

---

## 5) How to Create a Backup

Run this command in the project folder:

```bash
python backup_runner.py first-save
```

What this does:
- Creates a **new backup folder** (timestamped)
- Copies source files into that backup location
- Updates the CSV backup log (`sampleLog.csv`) with a new record

You can replace `first-save` with any label you want (for example: `before-tax-update`, `month-end`, etc.).

---

## 6) How to Use the Web App

1. Open `index.html` in your browser.
2. Go to the **Backup Log** tab.
3. Load the CSV log (or use auto-load, if enabled).
4. View your backup entries in a table.
5. Use search/filter tools to find specific backups quickly.
6. Click a row to preview details.
7. Use actions such as:
   - **Open Folder**
   - **Copy Path**

---

## 7) CSV Log Format

The log uses this structure:

```csv
Day,Backup date,folder path,No. of files,Type
```

### Column meaning (simple)

- **Day** → The weekday when backup was created (e.g., Monday)
- **Backup date** → Date/time of the backup
- **folder path** → Relative path to the backup folder
- **No. of files** → Number of files copied in that backup
- **Type** → Backup label/category (manual tag or mode)

Because it is CSV, you can also open it in Excel for reporting or audit tracking.

---

## 8) Folder Structure Explanation

```text
versionControl/
├─ index.html
├─ README.md
├─ backup_runner.py
├─ MAINFILE/
└─ versionControl/
   ├─ sampleLog.csv
   └─ _checkpoints/
```

### What each part means

- **`index.html`**  
  Your visual dashboard for viewing backup activity.

- **`backup_runner.py`**  
  Script that actually creates backups and updates the log.

- **`MAINFILE/`**  
  Your source/original working data (the data you want to protect).

- **`versionControl/sampleLog.csv`**  
  History log of backups in simple spreadsheet format.

- **`versionControl/_checkpoints/`**  
  Storage area for backup versions (timestamped snapshots).

---

## 9) Important Notes (Very Important)

- **All paths are relative** so the project is portable across machines.
- Browser security rules may prevent **Open Folder** from working in some cases.
- **Copy Path** is the most reliable option to locate backups.
- Creating backups must be done externally via **Python script** (`backup_runner.py`).

---

## 10) Create Backup Now Button

If you see a **Create Backup Now** button in the UI:

- It is currently a **placeholder** for future integration.
- Browsers cannot reliably run local system scripts directly for security reasons.
- For now, always run backups using the command line Python script.

---

## 11) Cross-Platform Support

This project is built to be portable:

- ✅ Works on **Linux**
- ✅ Works on **Windows**
- ✅ No OS-specific setup required for the dashboard
- ✅ Relative paths help keep backups movable across environments

---

## 12) Limitations

Current practical limitations:

- Browser cannot always open local folders/file explorer reliably.
- Backup creation still requires manual script execution.
- File/folder preview behavior depends on browser permissions and local security settings.

---

## 13) Future Improvements

Planned enhancement ideas:

- Auto backup trigger integration from the dashboard
- Desktop app version (Electron or Tauri)
- Real-time folder monitoring and scheduled checkpoints
- Better built-in preview support for backed-up files

---

## 14) Conclusion

This tool is designed to be:

- **Simple** to use
- **Portable** across machines
- **Safe** for local backup history
- Friendly for **non-technical users**

If you need checkpoint-style backups without Git complexity, this project gives you a clean and practical workflow.
