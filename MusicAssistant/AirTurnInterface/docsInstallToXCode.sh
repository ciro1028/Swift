#!/usr/bin/env bash

reset

cd "$( dirname "${BASH_SOURCE[0]}" )"

cp -R docs/com.airturn.AirTurn-Interface.docset ~/Library/Developer/Shared/Documentation/DocSets/

osascript <<'END'
tell application "Xcode"
	load documentation set with path POSIX path of ((path to home folder as string) & "Library:Developer:Shared:Documentation:DocSets:com.airturn.AirTurn-Interface.docset")
end tell
END

echo "Docs have been copied to ~/Library/Developer/Shared/Documentation/DocSets/ and loaded in XCode"