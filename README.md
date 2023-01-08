# Helper Commands for deploy

## Installation
Append this function to ~/.bashrc

```sh
# Helper path 
function helper () {

    cmd=$1
    if [ -z $cmd ]
    then
	printf "docker-clean        | hard, soft, view consist Containers, Network, Volumes without Images\r\n"
	printf "git-ftp             | Upload modify files to remote dir\r\n"
	printf "git-copy            | Copy modify files to .._admin\r\n"
	printf "git-tag             | Git Tag from commit Id or Head\r\n"
	printf "php-ver             | Chean php version\r\n"
	printf "vhost               | Set vhost with name[.loc] on [/var/www/vhosts/]Path\r\n"
        printf "quickadmin-extract  | Extract zip to Erkan hibes_admin on quickadmin branch\r\n"        
        printf "flutter             | Clean, Upgrade, Format and build APK [-apk]\r\n"


    else
    shift
    
    bash /home/amir/Dropbox/Helper/$cmd.sh "$@"
    fi
}


```

## Commands
For example

```sh
helper git_tag
```

| Comand | README |
| ------ | ------ |
|docker_clean        | hard, soft, view consist Containers, Network, Volumes without Images|
|git_copy            | Copy modify files to .._admin|
|git_tag             | Git Tag from commit Id or Head|
|php_ver             | Chean php version|
|vhost               | Set vhost with [.loc] on|

## License

MIT

**Free Software, Amir Hosseinzadeh!**

