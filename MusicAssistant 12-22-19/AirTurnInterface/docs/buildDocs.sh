#!/usr/bin/env bash

command -v appledoc >/dev/null 2>&1 || { echo >&2 "I require appledoc but it's not installed.  Aborting."; exit 1; }

cd "$( dirname "${BASH_SOURCE[0]}" )"

appledoc --create-docset -docsetutil-path `xcode-select -print-path`/usr/bin/docsetutil --docset-install-path "." --index-desc "README.md" --include "include" --no-install-docset --keep-undocumented-objects --keep-undocumented-members --company-id "com.airturn" --project-company "AirTurn" --project-name "AirTurn Interface" --output "." "../Framework-dynamic/AirTurnInterface.framework/Headers"

code=$?
if [ $code -gt 1 ]; then
	echo "Build docs failed (code $code)"
	exit 2
fi