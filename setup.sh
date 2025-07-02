#!/bin/bash
set -e

TARGET="";         if [ -d "Appearance" ]; then TARGET="Appearance/Themes/_fallback"; fi      

DIRECTORY="beat4sprite-OutFox"


# Clone repository.

REPOSITORY="https://github.com/EngineMachiner/beat4sprite-OutFox.git"

git clone "$REPOSITORY" "$DIRECTORY"


echo "Moving files...";             cp -r "$DIRECTORY/BGAnimations" "./"

cp -r "$DIRECTORY/Modules" "$TARGET"


rm -rf "$DIRECTORY"
