#!/bin/bash

pwd
rm -r "$PWD/CodeSnippets"
SNIPPETS_DIR="$HOME/Library/Developer/Xcode/UserData/CodeSnippets"
if [[ ! -e $SNIPPETS_DIR  ]]
then
mkdir -p $SNIPPETS_DIR
fi
ln -s "$HOME/Library/Developer/Xcode/UserData/CodeSnippets"
./in_move.sh
