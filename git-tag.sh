#!bin/bash

echo 'Starting...'
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

# calculate version

segmentFirst=$(( (count)/200 ))
segmentSecond=$(( ((count)%200)/20 ))
segmentThird=$(( ((count)%200)%20 ))

if [ "$segmentThird" -lt "10" ]
then
    segmentThird="0$segmentThird"
fi

version=$segmentFirst.$segmentSecond.$segmentThird

# Mark repository a new tag
git tag -a $version $commit_id -m "Version $varsion"
#git push origin $varsion

echo "Set Tag Version $version by $count !!!"
