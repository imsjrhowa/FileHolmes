# Folder Compare Tool

A simple Python tool that compares two folders and finds files that exist in the first folder but are missing from the second folder.

**Version: 1.0**

## Features

- **Simple comparison**: Finds missing files only (file size doesn't matter)
- **Recursive scanning**: Checks all subdirectories
- **Clear output**: Shows exactly which files are missing
- **Cross-platform**: Works on Windows, macOS, and Linux
- **Executable build**: Can be compiled to standalone .exe file
- **File output**: Saves results to missing_files.txt
- **Case sensitivity control**: Optional case-sensitive file name comparison
- **Version tracking**: Built-in version management and display

## Usage

### Python Script
```bash
python FileHolmes.py <source_folder> <target_folder> [--case-sensitive]
```

### Executable (Windows)
```cmd
FileHolmes.exe <source_folder> <target_folder> [--case-sensitive]
```

### Version Information
```bash
python FileHolmes.py --version
FileHolmes.exe --version
```

### Examples

**Windows:**
```cmd
python FileHolmes.py "C:\Source" "C:\Backup"
python FileHolmes.py "C:\Source" "C:\Backup" --case-sensitive
FileHolmes.exe "C:\Source" "C:\Backup"
FileHolmes.exe "C:\Source" "C:\Backup" --case-sensitive
```

**macOS/Linux:**
```bash
python FileHolmes.py /home/user/source /home/user/backup
python FileHolmes.py /home/user/source /home/user/backup --case-sensitive
```

**Current directory comparison:**
```bash
python FileHolmes.py . "C:\Backup"
python FileHolmes.py . "C:\Backup" --case-sensitive
```

## Case Sensitivity

- **Default behavior**: Case-insensitive comparison (recommended for most use cases)
- **Case-sensitive mode**: Use `--case-sensitive` flag for exact filename matching
- **Use cases**:
  - **Case-insensitive**: Windows systems, cross-platform compatibility
  - **Case-sensitive**: Linux/macOS systems, exact filename requirements

### Examples of Case Sensitivity

**Case-insensitive (default):**
- `Document.txt` and `document.txt` are considered the same file
- `Photo.jpg` and `photo.jpg` are considered the same file

**Case-sensitive:**
- `Document.txt` and `document.txt` are considered different files
- `Photo.jpg` and `photo.jpg` are considered different files

## Building the Executable

### Option 1: Batch File (Windows)
```cmd
build_exe.bat
```

### Option 2: PowerShell Script (Windows)
```powershell
.\build_exe.ps1
```

### Option 3: Manual Build
```bash
pip install pyinstaller
python -m PyInstaller --onefile --name "FileHolmes" --console FileHolmes.py
```

The executable will be created in the `dist/` folder.

## What It Does

1. **Scans the first folder** (source) and lists all files
2. **Scans the second folder** (target) and lists all files  
3. **Compares the lists** and finds files missing from the target
4. **Reports results** showing exactly which files are missing
5. **Saves report** to missing_files.txt for documentation
6. **Handles case sensitivity** based on user preference
7. **Tracks version information** in all outputs

## Output

### Console Output
```
============================================================
Folder Compare Tool - FileHolmes v1.0
============================================================
Source folder: C:\Source
Target folder: C:\Backup
Case sensitive: No
============================================================
Scanning first folder: C:\Source
Found 150 files in the first folder.

Scanning second folder: C:\Backup
Found 145 files in the second folder.

✗ Found 5 files missing from the second folder:
------------------------------------------------------------
  important_document.txt
  photos/vacation.jpg
  work/project.docx
  backup/old_file.bak
  temp/notes.txt
------------------------------------------------------------
Total missing files: 5

Saving results to missing_files.txt...
✓ Missing files report saved to: missing_files.txt

Comparison complete!
```

### File Output (missing_files.txt)
The tool creates a detailed report file with timestamp, version information, folder information, and case sensitivity setting.

## Requirements

- **Python 3.6+** (for running the script)
- **PyInstaller** (for building executable)
- **No additional packages** required (uses only standard library)

## Project Structure

```
FileHolmes/
├── FileHolmes.py          # Main Python script (v1.0)
├── build_exe.bat          # Windows batch file for building
├── build_exe.ps1          # PowerShell script for building
├── requirements.txt        # Build dependencies
├── .gitignore             # Git ignore file
├── README.md              # This file
├── dist/                  # Built executable (after build)
└── build/                 # Build artifacts (after build)
```

## Notes

- **File size doesn't matter** - only checks if files exist
- **Relative paths** are used for comparison
- **Subdirectories** are included automatically
- **Error handling** for invalid paths and permissions
- **Build artifacts** are automatically excluded from Git
- **Case sensitivity** is configurable via command line flag
- **Version tracking** is built into all outputs

## Use Cases

- **Backup verification**: Check if all source files were backed up
- **Sync validation**: Verify folder synchronization
- **Migration checking**: Ensure all files were moved
- **Archive verification**: Confirm backup completeness
- **Distribution**: Share the executable with users who don't have Python
- **Cross-platform compatibility**: Handle different case sensitivity requirements
- **Version management**: Track tool versions across deployments

## Git Integration

The `.gitignore` file is configured to exclude:
- Build artifacts and executables
- Generated reports (missing_files.txt)
- Python cache files
- IDE and OS-specific files

## Version History

- **v1.0** - Initial release with case sensitivity control and comprehensive reporting
