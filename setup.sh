#!/bin/bash

#this script will setup git specifics using the configs in this repo

# Check if the name and email has been updated.
# Exit if not.

PATTERN="NAME\|EMAIL"
FILE="gitconfig"
if grep -q $PATTERN $FILE;
then
    echo "You need to update your gitconfig file"
    echo "Put your actual name and email instead of '$PATTERN'"
    echo -e "$(grep $PATTERN $FILE)\n"
    echo -e "Then run:\n"
    echo -e "\t git config filter.updateName&Email.smudge "sed -e 's/EMAIL/<ACTUAL_EMAIL>/' -e 's/NAME/<ACTUAL_NAME>/'" "
    echo -e "\t git config filter.updateName&Email.clean "sed -e 's/<ACTUAL_EMAIL>/EMAIL/' -e 's/<ACTUAL_NAME>/NAME/'" "
    echo -e "\nSo that they stay untracked"
    echo "Exiting..."
    exit 1
else
    echo "The strings '$PATTERN' are not found in '$FILE'"
    echo -e "Proceeding\n"
fi

###### Unfortunately not working
# read -p "Input name: " name
# read -p "Input email: " email
# git config filter.updateNameEmail2.smudge  "sed -e 's/EMAIL/$email/' -e 's/NAME/${name}/' "
# exit 0


files="gitconfig gitignore gitexcludes"
date=`date +"%Y%m%d"`

files="gitconfig gitignore gitexcludes"
date=`date +"%Y%m%d"`

for file in $files; do
    if [ -h ~/.$file ]; then
        unlink ~/.$file
    else
        if [ -f ~/.$file ]; then
            echo "backing up ~/.$file to ~/.$file.bak$date"
            mv ~/.$file ~/.$file.bak$date
        fi
    fi
    echo "symlinking $PWD/$file to ~/.$file"
    ln -s $PWD/$file ~/.$file
done
