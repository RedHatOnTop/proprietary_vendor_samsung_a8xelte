#!/bin/bash
#
# Copyright (C) 2024 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

DEVICE=a8xelte
VENDOR=samsung
DEVICE_ROOT=vendor/$VENDOR/$DEVICE

INITIAL_COPYRIGHT_YEAR=2024

BASE="../../$VENDOR/$DEVICE"
PROP_FILES="$DEVICE_ROOT/proprietary-files.txt"

if [ ! -f "$PROP_FILES" ]; then
    echo "Error: $PROP_FILES not found!"
    exit 1
fi

function extract() {
    local SRC="$1"
    local SRC_ROOT="$2"
    local HASHTOOL="$3"

    if [ -z "$SRC" ]; then
        echo "Error: No source specified"
        echo "Usage: $0 <path-to-system-image> [<path-to-vendor-image>]"
        echo "   or: $0 <path-to-extracted-tree>"
        exit 1
    fi

    if [ -d "$SRC" ]; then
        echo "Extracting from directory: $SRC"
        SRC_ROOT="$SRC"
    else
        echo "Extracting from images is not yet implemented."
        echo "Please extract the system/vendor images first and provide the root directory."
        exit 1
    fi

    local FILELIST=( $(grep -v '^#' "$PROP_FILES" | grep -v '^$' | sort) )

    for FILE in "${FILELIST[@]}"; do
        local DIR=$(dirname "$FILE")
        local SRCFILE="$SRC_ROOT/$FILE"

        if [ -f "$SRCFILE" ]; then
            mkdir -p "$DEVICE_ROOT/proprietary/$DIR"
            cp -p "$SRCFILE" "$DEVICE_ROOT/proprietary/$FILE"
            echo "  Copied: $FILE"
        else
            echo "  MISSING: $FILE"
        fi
    done

    echo ""
    echo "Done! Files extracted to $DEVICE_ROOT/proprietary/"
}

CLEANUP=false

if [ "$1" = "--cleanup" ]; then
    CLEANUP=true
    shift
fi

if [ "$CLEANUP" = true ]; then
    echo "Cleaning up proprietary files..."
    rm -rf "$DEVICE_ROOT/proprietary/"
    echo "Done!"
    exit 0
fi

SRC="$1"
SRC_ROOT="$1"

if [ -z "$SRC" ]; then
    cat << EOF
Usage: $0 [--cleanup] <path-to-extracted-tree>
  --cleanup   Remove extracted proprietary files

Extracts a8xelte proprietary blobs from an extracted stock firmware tree.

Steps:
  1. Extract stock firmware (system.img / vendor.img) to a directory
  2. Run: $0 /path/to/extracted/tree
  3. Files will be copied to $DEVICE_ROOT/proprietary/
EOF
    exit 1
fi

extract "$SRC" "$SRC_ROOT"
