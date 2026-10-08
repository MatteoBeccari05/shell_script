#!/bin/bash

d="$1"
f="$2"

cd "$d" || exit 1

if test -f "$f"; then
    echo "Il file $f è in $d"
fi

for i in *; do
    if test -d "$i" -a -x "$i"; then
        echo "Direttorio: $d/$i"
        
        # Usa "$0" per richiamare se stesso in modo sicuro
        "$0" "$(pwd)/$i" "$f"
    fi
done