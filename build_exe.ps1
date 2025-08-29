# Build Executable for FileHolmes Tool
# This script will create a standalone .exe file

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "FileHolmes - Building Executable" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Python is available
try {
    $pythonVersion = python --version 2>&1
    Write-Host "Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Python is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Python and try again" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Checking for PyInstaller..." -ForegroundColor Yellow

# Check if PyInstaller is installed
try {
    python -c "import PyInstaller" 2>$null
    Write-Host "PyInstaller found!" -ForegroundColor Green
} catch {
    Write-Host "PyInstaller not found. Installing..." -ForegroundColor Yellow
    pip install pyinstaller
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to install PyInstaller" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
    Write-Host "PyInstaller installed successfully!" -ForegroundColor Green
}

Write-Host ""

# Clean previous builds
Write-Host "Cleaning previous builds..." -ForegroundColor Yellow
if (Test-Path "build") { Remove-Item -Recurse -Force "build" }
if (Test-Path "dist") { Remove-Item -Recurse -Force "dist" }
if (Test-Path "*.spec") { Remove-Item "*.spec" }
Write-Host "Cleanup complete." -ForegroundColor Green
Write-Host ""

# Build the executable
Write-Host "Building executable..." -ForegroundColor Yellow
Write-Host ""

# Build with PyInstaller
python -m PyInstaller --onefile --name "FileHolmes" --console FileHolmes.py

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "BUILD SUCCESSFUL!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Executable created: dist\FileHolmes.exe" -ForegroundColor Green
    Write-Host ""
    Write-Host "You can now run: .\dist\FileHolmes.exe <folder1> <folder2>" -ForegroundColor White
    Write-Host ""
    
    # Check if exe was created
    if (Test-Path "dist\FileHolmes.exe") {
        $fileInfo = Get-Item "dist\FileHolmes.exe"
        Write-Host "File size: $([math]::Round($fileInfo.Length / 1MB, 2)) MB" -ForegroundColor Green
        Write-Host ""
        Write-Host "Ready to use!" -ForegroundColor Green
    } else {
        Write-Host "WARNING: Executable not found in dist folder" -ForegroundColor Yellow
    }
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "BUILD FAILED!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Check the error messages above." -ForegroundColor Red
    Write-Host "Common issues:" -ForegroundColor Yellow
    Write-Host "- Missing dependencies" -ForegroundColor White
    Write-Host "- Python path issues" -ForegroundColor White
    Write-Host "- Permission problems" -ForegroundColor White
}

Write-Host ""
Write-Host "Press Enter to exit..."
Read-Host
