#!/usr/bin/env python3
"""
Folder Compare Tool
Compares two folders and finds files that exist in the first folder but are missing from the second folder.
File size doesn't matter - only checks for missing files.
Outputs results to missing_files.txt

Usage: python FileHolmes.py <folder1> <folder2> [--case-sensitive]
"""

import os
import sys
import argparse
from pathlib import Path
from datetime import datetime

# Version information
VERSION = "1.0"

def get_files_in_folder(folder_path, case_sensitive=True):
    """Get all files in a folder (recursively) and return their relative paths."""
    files = set()
    folder = Path(folder_path).resolve()
    
    if not folder.exists():
        print(f"Error: Folder '{folder_path}' does not exist.")
        return files
    
    if not folder.is_dir():
        print(f"Error: '{folder_path}' is not a directory.")
        return files
    
    try:
        for file_path in folder.rglob('*'):
            if file_path.is_file():
                # Get relative path from the source folder
                relative_path = file_path.relative_to(folder)
                # Convert to string and apply case sensitivity
                file_name = str(relative_path)
                if not case_sensitive:
                    file_name = file_name.lower()
                files.add(file_name)
    except Exception as e:
        print(f"Error reading folder '{folder_path}': {e}")
    
    return files

def compare_folders(folder1, folder2, case_sensitive=True):
    """Compare two folders and return files missing from the second folder."""
    print(f"Scanning first folder: {folder1}")
    files1 = get_files_in_folder(folder1, case_sensitive)
    
    if not files1:
        print("No files found in the first folder.")
        return set()
    
    print(f"Found {len(files1)} files in the first folder.")
    
    print(f"\nScanning second folder: {folder2}")
    files2 = get_files_in_folder(folder2, case_sensitive)
    
    if not files2:
        print("No files found in the second folder.")
        return set()
    
    print(f"Found {len(files2)} files in the second folder.")
    
    # Find files that are in folder1 but not in folder2
    missing_files = files1 - files2
    
    return missing_files

def save_missing_files_to_file(missing_files, folder1, folder2, case_sensitive=True):
    """Save the missing files list to missing_files.txt"""
    try:
        with open('missing_files.txt', 'w', encoding='utf-8') as f:
            f.write("=" * 80 + "\n")
            f.write("MISSING FILES REPORT\n")
            f.write("=" * 80 + "\n")
            f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"FileHolmes Version: {VERSION}\n")
            f.write(f"Source folder: {folder1}\n")
            f.write(f"Target folder: {folder2}\n")
            f.write(f"Case sensitive: {'Yes' if case_sensitive else 'No'}\n")
            f.write("=" * 80 + "\n\n")
            
            if not missing_files:
                f.write("✓ All files from the source folder exist in the target folder!\n")
            else:
                f.write(f"✗ Found {len(missing_files)} files missing from the target folder:\n")
                f.write("-" * 80 + "\n")
                
                # Sort files for better readability
                for file_path in sorted(missing_files):
                    f.write(f"  {file_path}\n")
                
                f.write("-" * 80 + "\n")
                f.write(f"Total missing files: {len(missing_files)}\n")
            
            f.write("\n" + "=" * 80 + "\n")
            f.write("END OF REPORT\n")
            f.write("=" * 80 + "\n")
        
        print(f"✓ Missing files report saved to: missing_files.txt")
        return True
        
    except Exception as e:
        print(f"✗ Error saving to file: {e}")
        return False

def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(
        description=f"Compare two folders and find missing files (v{VERSION})",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=f"""
Examples:
  python FileHolmes.py C:\\Source C:\\Backup
  python FileHolmes.py C:\\Source C:\\Backup --case-sensitive
  python FileHolmes.py . "C:\\Backup" --case-sensitive

FileHolmes v{VERSION} - Folder comparison tool
        """
    )
    
    parser.add_argument('folder1', help='Source folder (files to check)')
    parser.add_argument('folder2', help='Target folder (check if files exist here)')
    parser.add_argument('--case-sensitive', action='store_true', 
                       help='Enable case-sensitive file name comparison (default: case-insensitive)')
    parser.add_argument('--version', action='version', version=f'FileHolmes v{VERSION}')
    
    args = parser.parse_args()
    
    folder1 = args.folder1
    folder2 = args.folder2
    case_sensitive = args.case_sensitive
    
    print("=" * 60)
    print(f"Folder Compare Tool - FileHolmes v{VERSION}")
    print("=" * 60)
    print(f"Source folder: {folder1}")
    print(f"Target folder: {folder2}")
    print(f"Case sensitive: {'Yes' if case_sensitive else 'No'}")
    print("=" * 60)
    
    # Compare the folders
    missing_files = compare_folders(folder1, folder2, case_sensitive)
    
    if not missing_files:
        print("\n✓ All files from the first folder exist in the second folder!")
    else:
        print(f"\n✗ Found {len(missing_files)} files missing from the second folder:")
        print("-" * 60)
        
        # Sort files for better readability
        for file_path in sorted(missing_files):
            print(f"  {file_path}")
        
        print("-" * 60)
        print(f"Total missing files: {len(missing_files)}")
    
    # Save results to file
    print("\nSaving results to missing_files.txt...")
    save_missing_files_to_file(missing_files, folder1, folder2, case_sensitive)
    
    print("\nComparison complete!")

if __name__ == "__main__":
    main()
