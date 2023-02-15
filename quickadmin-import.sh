#!/bin/bash


path1="./storage/framework/cache/data/export"
path2="./"

cp -rf $path1/* $path2/
echo "All files and directories from $path1 have been copied to $path2, overwriting existing files."
