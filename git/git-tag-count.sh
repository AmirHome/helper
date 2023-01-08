#!bin/bash

home_dir=$PWD/
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

#####################################################

cd $home_dir

# get the from commit count
commit_id="$1"
if [ -z $commit_id ]
then
	commit_id='HEAD'
fi
count=`git rev-list --count $commit_id|head -n 1`

echo $count
