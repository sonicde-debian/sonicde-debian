#!/usr/bin/env bash
TO_BUILD="sonic-win sonic-workspace silver-theme silver-sddm sonicde"

for dir in $TO_BUILD; do
	if [ -d "$dir" ]; then
		echo -e "\e[31mAlready cloned\e[0m: $dir"
	else
		echo -e "\e[0;32mCloning\e[0m: $dir"
		git clone https://github.com/sonicde-debian/$dir || { echo "Failed to enter directory: $dir"; exit 1; }
	fi
done
