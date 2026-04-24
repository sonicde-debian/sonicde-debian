#!/usr/bin/env bash
export DEB_BUILD_OPTIONS="nocheck"
export FAILFAST="$1"

export CURRENTARCH=`arch`

TO_BUILD="sonic-interface-libraries sonic-screen-library sonic-system-info sonic-win sonic-workspace silver-theme silver-sddm sonic-desktop-interface sonicde"

ORIGINAL_DIR=`pwd`

for dir in $TO_BUILD; do
	if [ -d "$dir" ]; then
		echo -e "\e[0;32mBuilding in directory\e[0m: $dir"
		cd "$dir" || { echo "Failed to enter directory: $dir"; exit 1; }

		# not really needed
		git fetch origin pristine-tar:pristine-tar 2>/dev/null || true
		git fetch origin upstream/latest:upstream/latest 2>/dev/null || true

		apt-get build-dep . -y || true

		# don't sign packages, they will be signed in a repo.
		if ! gbp buildpackage --git-builder="debuild -i -I -us -uc" --git-debian-branch="debian/latest" --git-upstream-branch="upstream/latest" --git-pristine-tar; then
			echo -e "\e[31mFailed to build package\e[0m: $dir"
			if [ "$FAILFAST" = "true" ]; then
				exit 1
			fi
		fi

		cd "$ORIGINAL_DIR" || { echo "Failed to return to original directory"; exit 1; }

		if [ "$dir" = "sonic-interface-libraries" ]; then
			echo -e "\e[0;32mInstalling libsonicinterface-dev\e[0m"
			dpkg -i libsonicinterface7_*.deb
			apt-get install -f -y
			dpkg -i libsonicquick7_*.deb
			apt-get install -f -y
			dpkg -i sonic-desktoptheme_*.deb
			apt-get install -f -y
			dpkg -i libsonicinterface-dev_*.deb
			apt-get install -f -y
		fi
		if [ "$dir" = "sonic-win" ]; then
			echo -e "\e[0;32mInstalling sonic-win-dev\e[0m"
			dpkg -i sonic-win-data_*.deb
			apt-get install -f -y
			dpkg -i libsonicwin6_*.deb
			apt-get install -f -y
			dpkg -i sonic-win-dev_*.deb
			apt-get install -f -y
		fi
	else
		echo "Directory not found: $dir"
	fi
done
mkdir -p $ORIGINAL_DIR/build
mv *.build *.buildinfo *.changes *.deb *.xz *.gz *.dsc *.udeb $ORIGINAL_DIR/build || echo "Unable to move files to 'build' directory"
