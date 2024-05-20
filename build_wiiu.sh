#!/bin/bash

set -eo pipefail

PLATFORM_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$PLATFORM_DIR/"
BUILD_DIR="$ROOT_DIR/build/wiiu"
DIST_DIR="$BUILD_DIR/dist"


if [[ -z "$DEVKITPRO" ]]; then
	echo "env var DEVKITPRO is missing" 1>&2
	exit 1
fi

if [[ -z "$MAKE_OPTS" ]]; then
	MAKE_OPTS="-j$(nproc --all)"
fi

mkdir -p "$BUILD_DIR"

cd "$BUILD_DIR"
cmake -G"Unix Makefiles" "$ROOT_DIR" \
	-DCMAKE_BUILD_TYPE="$CMAKE_BUILD_TYPE" \
	-DCMAKE_TOOLCHAIN_FILE="$DEVKITPRO/cmake/WiiU.cmake"

make $MAKE_OPTS
