#!/bin/bash
set -e

FALLBACK="Themes/_fallback"         if [ -d "Appearance" ]; then FALLBACK="Appearance/$FALLBACK"; fi      

DIRECTORY="beat4sprite-OutFox"


# Clone repository.

REPOSITORY="https://github.com/EngineMachiner/beat4sprite-OutFox.git"

git clone "$REPOSITORY" "$DIRECTORY"


echo "Moving files...";             cp -r "$DIRECTORY/BGAnimations" "./"

cp -r "$DIRECTORY/Modules" "$FALLBACK"


rm -rf "$DIRECTORY"
