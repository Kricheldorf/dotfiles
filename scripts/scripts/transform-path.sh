#!/bin/bash

path="$1"

if [[ -z "$path" ]]; then
    path=$(wl-paste)
fi

if [[ "$path" == .platform-dist/* ]]; then
    path="${path#.platform-dist/}"
    path="${path%.*}"
fi

echo -n "$path" | wl-copy
