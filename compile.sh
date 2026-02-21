#!/usr/bin/env bash
export DEB_BUILD_OPTIONS="nocheck"
export FAILFAST="$1"

export CURRENTARCH=`arch`

TO_BUILD="sonic-win"

ORIGINAL_DIR=`pwd`

for dir in $TO_BUILD; do
	if [ -d "$dir" ]; then
		echo -e "\e[0;32mBuilding in directory\e[0m: $dir"
		cd "$dir" || { echo "Failed to enter directory: $dir"; exit 1; }

		# don't sign packages, they will be signed in a repo.
		if ! gbp buildpackage --git-builder="debuild -i -I -us -uc" --git-debian-branch="xlibre/latest"; then
			echo -e "\e[31mFailed to build package\e[0m: $dir"
			if [ "$FAILFAST" = "true" ]; then
				exit 1
			fi
		fi

		cd "$ORIGINAL_DIR" || { echo "Failed to return to original directory"; exit 1; }

	else
		echo "Directory not found: $dir"
	fi
done
mkdir -p $ORIGINAL_DIR/build
mv *.build *.buildinfo *.changes *.deb *.xz *.gz *.dsc *.udeb $ORIGINAL_DIR/build || { echo "Unable to move files to 'build' directory"; exit 1; }