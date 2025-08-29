@echo off
REM Build Executable for FileHolmes Tool
REM This script will create a standalone .exe file

echo ========================================
echo FileHolmes - Building Executable
echo ========================================
echo.

REM Check if Python is available
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python and try again
    pause
    exit /b 1
)

echo Python found. Checking for PyInstaller...
echo.

REM Check if PyInstaller is installed
python -c "import PyInstaller" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo PyInstaller not found. Installing...
    pip install pyinstaller
    if %ERRORLEVEL% NEQ 0 (
        echo ERROR: Failed to install PyInstaller
        pause
        exit /b 1
    )
    echo PyInstaller installed successfully!
    echo.
) else (
    echo PyInstaller found!
    echo.
)

REM Clean previous builds
echo Cleaning previous builds...
if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"
if exist "*.spec" del "*.spec"
echo Cleanup complete.
echo.

REM Build the executable
echo Building executable...
echo.

REM Build with PyInstaller
pyinstaller --onefile --name "FileHolmes" --console FileHolmes.py

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo BUILD SUCCESSFUL!
    echo ========================================
    echo.
    echo Executable created: dist\FileHolmes.exe
    echo.
    echo You can now run: dist\FileHolmes.exe <folder1> <folder2>
    echo.
    
    REM Check if exe was created
    if exist "dist\FileHolmes.exe" (
        echo File size: 
        dir "dist\FileHolmes.exe" | find "FileHolmes.exe"
        echo.
        echo Ready to use!
    ) else (
        echo WARNING: Executable not found in dist folder
    )
) else (
    echo.
    echo ========================================
    echo BUILD FAILED!
    echo ========================================
    echo.
    echo Check the error messages above.
    echo Common issues:
    echo - Missing dependencies
    echo - Python path issues
    echo - Permission problems
)

echo.
echo Press any key to exit...
pause >nul
