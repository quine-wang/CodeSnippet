#!/bin/bash

pwd
rm -r "$PWD/CodeSnippets"
ln -s "$HOME/Library/Developer/Xcode/UserData/CodeSnippets"
./in_move.sh