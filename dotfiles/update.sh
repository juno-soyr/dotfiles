#!/bin/bash

# List of folders to copy from ~/.config
folders=("eww" "alacritty" "rofi" "wallust" "doom" "sway" "swaync" "waybar")  # Add or remove as needed

# Destination is the current directory where the script is run
dest_dir="$(pwd)"

echo "Copying config folders to: $dest_dir"

for folder in "${folders[@]}"; do
  src="$HOME/.config/$folder"
  if [ -d "$src" ]; then
    echo "Copying $folder..."
    cp -r "$src" "$dest_dir/"
  else
    echo "Warning: $folder does not exist in ~/.config"
  fi
done

echo "Done."
