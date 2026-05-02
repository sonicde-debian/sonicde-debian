#!/usr/bin/env bash
TO_BUILD="sonic-interface-libraries sonic-screen-library sonic-screenlocker sonic-screen sonic-system-info sonic-win sonic-workspace silver-theme silver-sddm sonic-desktop-interface sonicde"

for dir in $TO_BUILD; do
	if [ -d "$dir" ]; then
		echo -e "\e[31mAlready cloned\e[0m: $dir"
	else
		echo -e "\e[0;32mCloning\e[0m: $dir"
		git clone https://github.com/sonicde-debian/$dir || { echo "Failed to enter directory: $dir"; exit 1; }
	fi
done
