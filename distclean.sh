#!/usr/bin/env bash
TO_BUILD="build sonic-win sonic-workspace silver-theme silver-sddm sonicde"
ORIGINAL_DIR="$(pwd)"

for dir in $TO_BUILD; do
	if [ -d "$dir" ]; then
		echo -e "\e[0;31mRemoving\e[0m: $dir"
		rm -rf "$ORIGINAL_DIR/$dir" || { echo "Failed to remove directory: $dir"; exit 1; }
	else
		echo "Directory not found: $dir"
	fi
done
