#!/bin/sh

# Run the swiftlint tool on a specific path, which is expected to correspond to
# a layer of the app.
#
# Dependencies:
#	- swiftlint >= 0.47.1
#
# Changelog:
#	[2022-06-25] Created script.

declare -r pathToBeLinted=$1
if test -z "$pathToBeLinted"; then
	echo 'Script called without a path to pass to the linter'
	exit 1
fi

if test -d '/opt/homebrew/bin/'; then
	PATH="/opt/homebrew/bin/:${PATH}"
fi

if which swiftlint >/dev/null; then
	swiftlint "$pathToBeLinted"
else
	echo 'warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint'
fi
