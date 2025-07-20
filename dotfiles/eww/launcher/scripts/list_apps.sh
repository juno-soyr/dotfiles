#!/bin/bash
# List installed applications from .desktop files
find /usr/share/applications ~/.local/share/applications -name "$1*.desktop" | while read -r file; do
    name=$(grep -m1 "^Name=" "$file" | cut -d= -f2-)
    exec=$(grep -m1 "^Exec=" "$file" | cut -d= -f2- | sed 's/ *%[uUfF]//g')
    if [ -n "$name" ] && [ -n "$exec" ]; then
        echo "$name::$exec"
    fi
done