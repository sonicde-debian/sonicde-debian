#!/usr/bin/env bash
TO_BUILD="sonic-win sonic-workspace silver-theme silver-sddm sonicde"
ORIGINAL_DIR="$(pwd)"

for dir in $TO_BUILD; do
	if [ -d "$dir" ]; then
		echo -e "\e[0;32mCleaning in directory\e[0m: $dir"
		cd "$dir" || { echo "Failed to enter directory: $dir"; exit 1; }

		debian/rules clean

		cd "$ORIGINAL_DIR" || { echo "Failed to return to original directory"; exit 1; }
	else
		echo "Directory not found: $dir"
	fi
done