#!/usr/bin/env bash

USERNAME=`whoami`;
BASEDIR=$(dirname "$0")

echo ""
git status
echo ""

PS3='Please enter your choice: '
options=("push all" "add and commit" "Quit")
select opt in "${options[@]}"
do

    case $opt in
        "push all")
            # push all
            bash $BASEDIR/git/git_push_all.sh
            
            break
            ;;
        "add and commit")
            # add and commit
            bash $BASEDIR/git/git_add_commit.sh "$@"

            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

