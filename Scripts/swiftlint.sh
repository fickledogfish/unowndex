#!/bin/sh

declare -r pathToBeLinted=$1

if test -d "/opt/homebrew/bin/"; then
	PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH

if which swiftlint >/dev/null; then
	swiftlint $pathToBeLinted
else
	echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
