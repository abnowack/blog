#!/bin/bash

PATH="/home/anowack/.local/anaconda3/bin:$PATH"
cd /mnt/c/Users/Aaron\ Nowack/home/GitHub/blog

if python run.py; then
    echo "Ran ButteredPost - Success";
else
    echo "Ran ButteredPost - Failure";
    read -p "Fix Error and Retry? [y|n]" choice
    case "$choice" in
        y|Y ) exec "$0";;
        n|N ) exit;;
        * ) exit;;
    esac
fi

if [ -z "$1" ]; then
    exit;
fi

if [ -n "$(git status --porcelain)" ]; then
    git add --all
    git commit -m "adding files"
else
    echo "no changes";
fi

if [ -n "$(git log origin/master..HEAD)" ]; then
    git push;
else
    echo "nothing to push";
fi
