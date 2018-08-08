#!/bin/bash
#this script will setup git specifics using the configs in this repo

files="gitconfig gitignore gitexcludes"
date=`date +"%Y%m%d"`

PATTERN="NAME\|EMAIL"
FILE="gitconfig"
if grep -q $PATTERN $FILE;
then
    # echo "Here are the Strings with the Pattern '$PATTERN':"
    echo "You need to update your gitconfig file"
    echo "Put your actual name and email instead of '$PATTERN'"
    echo "Leave the #gitignore comments at the end!"
    echo -e "$(grep $PATTERN $FILE)\n"
    echo "Exiting..."
    exit 1
else
    echo "The strings '$PATTERN' are not found in '$FILE'"
    echo -e "Proceeding\n"
fi

IGNORE="#gitignore"
if grep -q $IGNORE $FILE;
then
    echo "The ignore comments '$IGNORE' are in:"
    echo "$(grep $IGNORE $FILE)"
    echo -e "Proceeding\n"
else
    echo "Error: The Pattern '$IGNORE' was NOT Found in '$FILE'"
    echo "Exiting..."
    exit 1
fi


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
