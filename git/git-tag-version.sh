#!bin/bash

BASEDIR=$(dirname "$0")

home_dir=$PWD/
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

#####################################################

# calculate version

count=$(bash $BASEDIR/git-tag-count.sh)


segmentFirst=$(( (count)/200 ))
segmentSecond=$(( ((count)%200)/20 ))
segmentThird=$(( ((count)%200)%20 ))

if [ "$segmentThird" -lt "10" ]
then
    segmentThird="0$segmentThird"
fi

version=$segmentFirst.$segmentSecond.$segmentThird

# echo "Set Tag Version $version by $count !!!"

echo $version;