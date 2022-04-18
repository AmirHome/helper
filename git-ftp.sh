#!/bin/bash

expected_args=1
e_badargs=65
home_dir=$PWD
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

#######################################    Initial    #######################################
# ----------------------------------   Local .env.git_ftp  ----------------------------------

if [ -f .env.git_ftp ]; then
    # Load Environment Variables
    export $(cat .env.git_ftp | grep -v '#' | awk '/=/ {print $1}')

	printf "\r\n$REMOTE_PROTOCOL $REMOTE_HOST $REMOTE_USER\r\n\r\n" 

else
    echo "Error: .env.git_ftp is not exist."
	printf "\r\n.env.git_ftp.example\r\n"
	echo "# Environment Variables"
	echo "REMOTE_PROTOCOL=ftp"
	echo "REMOTE_HOST=amirhome.com"
	echo "REMOTE_USER=3532271"
	echo "REMOTE_PASSWD=*********"
	echo "REMOTE_DIR=var/www/html/"

	exit
fi

printf "$home_dir >> $REMOTE_DIR \r\n\r\n\r\n" 

read -p "Are you sure? " -n 1 -r
if [[ ! $REPLY =~ [Yy]$ ]]
then
   exit 1
fi

#######################################  from commit lastest commit  ###########################
if [ $# -lt $expected_args ]
then
    printf "\r\nError: you should use from_tag [to_tag] OR init\r\n"
    exit $e_badargs
fi

cd $home_dir

to_tag="HEAD@{0}"
if [ ! -z "$2" ]
then
	# to_tag="$2"
	# get the lastest commit via tag name
	to_tag=`git rev-list $2|head -n 1`
fi

from_tag="$1"
if [ -z $from_tag ]
then
	echo "Error no from tag"
	exit
fi


if [ $from_tag == "init" ]
then
	git_list_file_changed="`git ls-tree --name-only HEAD`"
else
	git_list_file_changed="`git diff --name-only --diff-filter=d $from_tag $to_tag`"
fi



######################################### FTP server ########################################
count_file=0
IFS=$'\n'
# get list file changed and push to FTP server
for file_change in $git_list_file_changed
do
	echo "Put $file_change ... "
	count_file=$((count_file+1))
    # call FTP script to push file via curl
	echo $file_change $REMOTE_DIR$file_change
	#bash /home/amir/Dropbox/Helper/ftp.sh $file_change $REMOTE_DIR$file_change
done

#########################################   new tag    ########################################
# Mark repository a new tag
# if [ $count_file -gt 0 ]
# then

# 	git tag -a $new_tag -m "Version $new_tag"
# 	git push origin $new_tag
# fi

echo "Put $count_file DONE!!!"
