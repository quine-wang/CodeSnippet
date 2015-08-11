#!/bin/bash

pwd
if [[ -e $PWD/CodeSnippets ]]; then
	rm -r $PWD/CodeSnippets
fi
ln -s $HOME/Library/Developer/Xcode/UserData/CodeSnippets .
./in_move.sh