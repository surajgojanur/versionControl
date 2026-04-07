# Usability analysis: file/folder name dependency in checkpoint flow

## Scope inspected
- `index.html` (all checkpoint, restore, and backup-log logic)
- `README.md`
- `run_backup.sh`
- `run_backup.bat`

## Key findings
1. The checkpoint feature is **not hard-coded to one literal file name** (like `mainFile.xlsx`) in the browser app.
2. But it **is hard-coded to a naming-derived folder convention**: checkpoints are stored and read from `_checkpoints/<selected file base name>/...`.
3. This creates a practical break condition: if the tracked file is renamed after checkpoints are created, older checkpoints disappear from the UI and restore/open fails because lookup always uses the *current* selected file name.
4. The shell scripts are hard-coded to `MAINFILE/mainFile.xlsx` and `versionControl/_checkpoints/mainFile` (plus one mismatch in `.sh` log path), but those scripts are separate from the browser checkpoint save/restore path.

## Evidence
- Save logic derives checkpoint slot from selected file base name and writes file using selected file name.
- Refresh/list logic derives folder lookup from selected file base name.
- Open/restore logic expects selected file name to exist inside each checkpoint folder.
- UI/messages and README reinforce this file-name-based grouping model.

## UX risk summary
For non-technical users, renaming `sales.xlsx` to `sales-final.xlsx` is normal. In current behavior, that rename silently disconnects prior checkpoints from the visible history because grouping key is the file name string, not a stable per-target identity.

## Suggested MVP direction
Use stable target metadata (manifest) per tracked item:
- Keep `_checkpoints` as storage root.
- Add target manifest keyed by persistent target id.
- Store snapshots under that id, with recorded original filename + relative path.
- Resolve restore/open using manifest mapping, not current selected filename string.

This keeps UX simple while removing name fragility.
