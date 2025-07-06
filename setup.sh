#!/bin/bash
set -e

TARGET="Modules";         if [ -d "Appearance" ]; then TARGET="Appearance/Themes/_fallback"; fi      

DIRECTORY="beat4sprite-OutFox"


# Clone repository.

REPOSITORY="https://github.com/EngineMachiner/beat4sprite-OutFox.git"

#git clone "$REPOSITORY" "$DIRECTORY"


while true; do

    while true; do

        # Branch checkout.

        echo "Please enter the branch name.";

        read BRANCH;        git -C "$DIRECTORY" checkout "$BRANCH" || continue


        echo "Moving files...";             cp -r "$DIRECTORY/BGAnimations" "./"

        cp -r "$DIRECTORY/Modules" "$TARGET"

        break

    done


    echo "Clone another branch?"

    select OPTION in "Yes" "No"; do break; done

    if [ $OPTION == "No" ]; then break; fi

done


rm -rf "$DIRECTORY";        echo "Exiting..."
