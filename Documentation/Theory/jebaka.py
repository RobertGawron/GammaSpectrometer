#!/usr/bin/env python3
"""
Combine all Markdown files in the current directory into a single text file.
"""

import os
from pathlib import Path
from typing import List


def find_md_files(directory: str = ".") -> List[Path]:
    """
    Find all .md files in the specified directory.

    Args:
        directory: Directory to search (default: current directory)

    Returns:
        List of Path objects for .md files, sorted alphabetically
    """
    path = Path(directory)
    md_files = sorted(path.glob("*.md"))
    return md_files


def combine_md_files(output_file: str = "combined_output.txt") -> None:
    """
    Combine all .md files into a single .txt file.

    Args:
        output_file: Name of the output file (default: combined_output.txt)
    """
    md_files = find_md_files()

    if not md_files:
        print("No .md files found in the current directory.")
        return

    print(f"Found {len(md_files)} .md file(s):")
    for md_file in md_files:
        print(f"  - {md_file.name}")

    with open(output_file, 'w', encoding='utf-8') as outfile:
        for i, md_file in enumerate(md_files):
            # Write header for each file
            outfile.write("=" * 80 + "\n")
            outfile.write(f"This is the content of {md_file.name}\n")
            outfile.write("=" * 80 + "\n\n")

            # Read and write the content of the .md file
            try:
                with open(md_file, 'r', encoding='utf-8') as infile:
                    content = infile.read()
                    outfile.write(content)

                    # Add spacing between files (except for the last one)
                    if i < len(md_files) - 1:
                        outfile.write("\n\n\n")

                print(f"✓ Added {md_file.name}")

            except Exception as e:
                print(f"✗ Error reading {md_file.name}: {e}")
                outfile.write(f"[Error reading file: {e}]\n\n\n")

    print(f"\n✓ Successfully combined {len(md_files)} file(s) into '{output_file}'")
    print(f"Output file size: {os.path.getsize(output_file)} bytes")


def main():
    """Main entry point."""
    import argparse

    parser = argparse.ArgumentParser(
        description="Combine all .md files in current directory into a single .txt file"
    )
    parser.add_argument(
        "-o", "--output",
        default="combined_output.txt",
        help="Output file name (default: combined_output.txt)"
    )
    parser.add_argument(
        "-d", "--directory",
        default=".",
        help="Directory to search for .md files (default: current directory)"
    )

    args = parser.parse_args()

    # Change to specified directory if provided
    if args.directory != ".":
        original_dir = os.getcwd()
        os.chdir(args.directory)
        print(f"Changed to directory: {os.path.abspath(args.directory)}\n")

    combine_md_files(args.output)

    # Change back to original directory
    if args.directory != ".":
        os.chdir(original_dir)


if __name__ == "__main__":
    main()
