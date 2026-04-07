# Folder Checkpoint Tool

This tool helps you save safe checkpoints of an Excel or CSV file while you work.
It is made for everyday office use, not for programmers.
If a file gets changed by mistake, you can restore an older saved copy without replacing your current file directly.

## Who this is for

This tool is for people who work with important files and want peace of mind, for example:

- Accountants
- Excel-heavy users
- Tally users
- Office/admin staff
- Anyone creating file names like `final_v2_last_final.xlsx`

## Why this tool is useful

If you have ever:

- overwritten the wrong Excel file,
- lost an older correct version,
- created too many confusing copies,
- felt afraid to edit a file because you might break it,

this tool is for you.

It gives you simple checkpoints so you can go back when needed.

## What this tool does

In the current version, this tool works like this:

1. You choose a **working folder**.
2. You choose one **Excel (`.xlsx`) or CSV (`.csv`) file**.
3. You click **Save Version** to store a checkpoint.
4. Saved checkpoints are kept inside:
   - `versionControl/_checkpoints/` (inside your selected folder)
5. You can later:
   - download an older saved copy (**Open**), or
   - create a restored copy in your working folder (**Restore**).

> Important: Right now, the app saves checkpoints for the **selected file**, not the full folder contents.

## What this tool does NOT do

To avoid confusion, here is what it does **not** do:

- It does not edit your Excel or CSV data by itself.
- It does not upload your files to the cloud.
- It does not share your data automatically.
- It does not replace Excel or Tally.
- It does not behave like Google Drive sync.
- It does not overwrite your current file during restore.
  - It creates a **new restored file** with `_restored_...` in the name.

## Before you start

Please make sure you have:

1. A Chromium-based browser (recommended):
   - Google Chrome or Microsoft Edge
2. This project folder available on your computer
3. Permission to allow folder and file access when your browser asks

If your browser does not support folder access, some features may not work.

## How to open and run the tool

1. Keep this project folder on your computer.
2. Open `index.html` in Google Chrome or Microsoft Edge.
3. On the **Checkpoints** tab, click the folder box (**Workspace Folder**) and choose your working folder.
4. Click the file box (**Target File (.xlsx / .csv)**) and choose your file.
5. (Optional) Type a short note in **Note (optional)**.
6. Click **Save Version**.

That’s it. Your checkpoint is now saved locally.

## How to use it — step by step

### 1) Select your working folder

Choose the folder where your real files are kept (example: `ClientA` or `March-GST-Files`).

Try to choose one stable folder you normally use, instead of moving between many folders.

### 2) Select the file you want to protect

Click **Target File (.xlsx / .csv)** and choose one file.

Examples:

- `sales.xlsx`
- `gst-summary.csv`

### 3) Save a checkpoint

Click **Save Version** whenever you want a safe point.

Good times to save:

- before editing formulas
- before GST/tax updates
- before cleanup or delete actions
- before sharing file with others

You can add a short note like:

- `before-gst`
- `before-april-close`

### 4) View older checkpoints

Saved versions appear in the list on the right side.

Each entry shows:

- date/time
- your note
- file name

### 5) Use an older checkpoint

For any saved version, you have two actions:

- **Open**: downloads that saved version to your computer.
- **Restore**: writes a restored copy into your selected working folder.

Restore example name:

- `sales_restored_2026-04-07_14-35.xlsx`

So your current `sales.xlsx` is not overwritten directly.

## Example workflow (accountant example)

1. You keep client files in `ClientA`.
2. You select folder `ClientA` and file `sales.xlsx`.
3. You save a checkpoint with note `before-gst`.
4. You make GST edits and later notice a mistake.
5. In the saved versions list, you click **Restore** on the earlier checkpoint.
6. A new file appears in `ClientA` (example: `sales_restored_2026-04-07_14-35.xlsx`).
7. You open the restored file, verify data, and continue safely.

## Where checkpoints are stored

Inside your selected working folder, checkpoints are saved in this path:

```text
YourWorkingFolder/
  versionControl/
    _checkpoints/
      sales/
        2026-04-07_14-35_before-gst/
          sales.xlsx
```

Another example:

```text
ClientA/
  sales.xlsx
  report.xlsx
  versionControl/
    _checkpoints/
      sales/
        2026-04-06_18-30_before-gst/
          sales.xlsx
```

What this means:

- `_checkpoints` is the storage area for saved versions.
- Each file gets its own subfolder (example: `sales`).
- Each checkpoint gets its own timestamp + note folder.

## How restore works

When you click **Restore**:

1. The tool reads the selected saved checkpoint.
2. It creates a **new file** in your working folder.
3. The new file name includes `_restored_` and a timestamp.

Why this is safer:

- Your current file is not replaced automatically.
- You can compare the current file and restored file before deciding what to keep.

After restore, you can:

- open both files,
- copy required sheets/data,
- keep the best one.

## Tips for safe use

- Save a checkpoint before major edits.
- Write meaningful notes (`before-audit`, `before-month-close`).
- Do not manually edit checkpoint folders unless you understand the impact.
- Avoid renaming/moving the working folder while actively using the page.
- Keep enough disk space for multiple saved copies.

## Common questions (FAQ)

### Will this upload my files anywhere?
No. It runs locally in your browser and saves locally.

### Will this delete my original files?
No. Save and restore actions create copies; restore creates a new file name.

### Can I use this for Excel files?
Yes. `.xlsx` is supported.

### Can I use this for CSV files?
Yes. `.csv` is supported.

### Can I protect a full folder in one click?
Not in the current version. Right now, checkpoints are saved for the selected file.

### What happens if I save many checkpoints?
All are kept in the checkpoint folder until you remove old ones.

### Can I delete old checkpoints later?
Yes, but do it carefully. Keep at least a few recent safe points.

## Troubleshooting

### Browser does not show folder picker

- Use Google Chrome or Microsoft Edge.
- Make sure you opened `index.html` directly.
- Refresh and try again.

### Nothing happens after clicking Save Version

- Confirm both are selected:
  - workspace folder
  - target file
- Check if browser showed a permission prompt.

### Permission denied for folder/file

- Try selecting the folder and file again.
- Allow access when browser asks.

### Checkpoint not visible in list

- Confirm you selected the same file name as before.
- Save again and wait a moment.
- Re-select the folder and file to refresh the list.

### Restored copy not found

- Look in the selected working folder.
- Search for file names containing `_restored_`.

## Privacy note

Your files stay on your own computer.
This tool works locally in your browser.
There is no cloud upload in the current implementation.

(There is a separate **Backup Log** tab for viewing CSV backup records, but the browser button **Create Backup Now** is currently not connected to a real backup trigger.)

## Closing note

This tool is made to reduce fear while working with important files.
Use checkpoints often, and you can work with more confidence and less stress.
