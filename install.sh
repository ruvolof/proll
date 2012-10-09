#!/bin/bash

PREFIX="/usr/"
BIN="$PREFIX/bin/proll"

function help {
	echo "Usage: ./install.sh <options>"
	echo "Available options:"
	echo "	-h, --help	Show this help and exit."
	echo "	uninstall	Uninstall PRoll."
}

function get_bin {
	PATH=`which proll`
	return $PATH
}

function uninstall {
	if [ -e "$BIN" ] ; then
		if [ $1 -eq 0 ] ; then
			echo "Removing $BIN..."
			rm $BIN
		else
			echo "You need root privileges to uninstall it."
		fi
	elif [ -e "$HOME/bin/proll" ] ; then
		echo "Removing $HOME/bin/proll..."
		rm "$HOME/bin/proll"
	else
		echo "PRoll doesn't seem to be installed."
	fi
}

if [[ "$*" =~ -h ]] || [[ "$*" =~ --help ]] ; then
	help
	exit 0
fi

ROOT=`id -u`

if [[ "$*" =~ uninstall ]] ; then
	uninstall $ROOT
	exit 0
fi

if [ $ROOT -eq 0 ] ; then
	if [ ! -e "$BIN" ] ; then
		echo "Copying $PWD/proll.pl to $BIN..."
		cp proll.pl /usr/bin/proll
	else
		echo "You already have $BIN on your system."
	fi
else
	mkdir -p "$HOME/bin"
	if [ ! -e "$HOME/bin/proll" ] ; then
		echo "Copying $PWD/proll.pl to $HOME/bin/proll..."
		cp proll.pl "$HOME/bin/proll"
	else
		echo "You already have $HOME/bin/proll on your system."
	fi
	HOME_BIN=`which proll 2>/dev/null`
	if [[ "$HOME_BIN" =~ $HOME/bin/proll ]] ; then
		echo "PATH variable is set correctly."
	else
		NEW_PATH='PATH=$HOME/bin:$PATH ; export PATH'
		echo "Adding $HOME/bin to PATH..."
		echo "$NEW_PATH" >> "$HOME/.bashrc"
		echo "You need to restart the shell in order to make it working."
	fi
fi

exit 0
	
