#!/usr/bin/env bash

USERNAME=`whoami`;
BASEDIR=$(dirname "$0")

echo ""
    count=$(sudo bash $BASEDIR/git/git-tag-count.sh)
    version=$(sudo bash $BASEDIR/git/git-tag-version.sh)

    echo "Set Tag Version $version by $count !!!"

    git status
echo ""

PS3='Please enter your choice: '
options=("push all" "Add and Commit" "Add & Commit with Push All" "Count and git Tag" "Quit & Ctrl + C")
select opt in "${options[@]}"
do

    case $opt in
        "push all")
            # push all
            bash $BASEDIR/git/git_push_all.sh
            
            break
            ;;
        "Add and Commit")
            # add and commit
            bash $BASEDIR/git/git_add_commit.sh "$@"

            break
            ;;
        "Add & Commit with Push All")
            # Add & Commit with Push All
            bash $BASEDIR/git/git_add_commit.sh "$@"

            bash $BASEDIR/git/git_push_all.sh
            
            break
            ;;
        "Count and git Tag")
            bash $BASEDIR/git/git-tag.sh

            break
            ;;
        "Quit & Ctrl + C")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

