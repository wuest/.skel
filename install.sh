#!/bin/bash

# For each file/directory in the top level of the skeleton directory move the
# corresponding file in $HOME aside, appending '.backup' to its name, then
# symlink the file from the current (.skel) directory to $HOME.
#
# Any file which meets either of the two criteria will be skipped:
# * The target file is already a symlink
# * The backup file/directory to be created already exists

RESET="\033[0m"
RED="\033[31m"
BLUE="\033[34m"

for I in $(git ls-files|cut -d'/' -f1|grep -v install.sh); do
	TARGET="$HOME/$I"
	SRC=`pwd`"/$I"
	if [ ! -L "$TARGET" ]; then
		if [ -f $TARGET -o -d $TARGET ]; then
			printf "$RED""$TARGET exists, backing up... $RESET"
			if [ -f "$TARGET".backup -o -d "$TARGET".backup ]; then
				printf "$RED""$TARGET"".backup exists, skipping.$RESET\n"
				continue
			fi
			mv "$TARGET" "$TARGET".backup && printf "$BLUE""OK$RESET\n"
		fi
		printf "$BLUE""installing $I""... "

		printf "$RED"
		ln -s "$SRC" "$TARGET" && printf "$BLUE""OK$RESET\n"
	fi
done

# Add vim directories
mkdir -p $HOME/.vim/{backup,tmp}

# Add Vundle
git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

# Install vundle + plugins listed in .vimrc
vim -e +BundleInstall +qall
