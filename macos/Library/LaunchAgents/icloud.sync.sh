#! /usr/bin/env sh

SRC="$HOME/Sync/"
DEST="$HOME/Library/Mobile Documents/com~apple~CloudDocs/30 Resources/Sync"

if [ -d "${DEST}" ]; then
	rsync -qau --exclude ".*" "${SRC}" "${DEST}/"
	osascript -e 'display notification "File sync complete!" with title "iCloud Sync"'
fi
