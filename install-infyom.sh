#!/bin/bash
# Installer for InfyOm Generator

USERNAME=`whoami`;
BASEDIR=$(dirname "$0")
VHOSTDIR=$HOME/data/Codes/vhosts

projectName=$1
if [ -z $projectName ]
then
        echo -e "\033[31m Error: should set Project Name \e[0m";
        exit
fi

projectDir=${projectName//[-]/_}
projectPATH=$VHOSTDIR/$projectDir


git clone https://github.com/InfyOmLabs/adminlte-generator.git $projectName 

cd $projectPATH

# composer require infyomlabs/laravel-generator
# composer require laravelcollective/html
# composer require infyomlabs/adminlte-templates

composer update

# nl=$"\n"
# sed -i "/\/\/ 'ExampleClass'/i \
# 'Form'      => Collective\Html\FormFacade::class,${nl}\
# 'Html'      => Collective\Html\HtmlFacade::class,${nl}\
# 'Flash'     => Laracasts\Flash\Flash::class,${nl}\
# " config/app.php


# php artisan vendor:publish --provider="InfyOm\Generator\InfyOmGeneratorServiceProvider"

# composer require laravel/ui:^3.0

# php artisan ui bootstrap --auth

# php artisan infyom.publish:layout 

cp .env.example .env
sed -i "s/DB_DATABASE=laravel/DB_DATABASE=$projectName/" .env

read -p "Sure to set .env to migration!? [Y]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    php artisan migrate:fresh
fi

php artisan key:generate


### Generator GUI Interface
### https://infyom.com/open-source/gui-interface/docs
composer require infyomlabs/generator-builder:^1.0

### Datatables
### https://infyom.com/open-source/laravelgenerator/docs/generator-options
composer require yajra/laravel-datatables-oracle:"~9.0"
composer require yajra/laravel-datatables-buttons:^4.0
composer require yajra/laravel-datatables-html:^4.0


### Composer Update
composer update

### Add Service Provider
sed -zi 's/\* Package Service Providers\.\.\.\n\s*\*\//\* Package Service Providers\.\.\.\n         \*\/\
        \\/\/InfyOm\GeneratorBuilder\GeneratorBuilderServiceProvider::class,/' \
        config/app.php

php artisan vendor:publish --provider="InfyOm\GeneratorBuilder\GeneratorBuilderServiceProvider"
php artisan vendor:publish --provider="Yajra\DataTables\DataTablesServiceProvider"

php artisan infyom.publish:generator-builder

php artisan vendor:publish --tag=datatables
php artisan vendor:publish --tag=datatables-html
php artisan vendor:publish --tag=datatables-buttons --force

### Set Helpers
mkdir -p 'app/Helpers'

tee app/Helpers/Helpers.php << END
<?php

/*
 * composer.json
      "autoload": {
         "files": ["app/Helpers/Helpers.php"],
 * composer dump-autoload
 * */

//ini_set('max_execution_time', '600');
//ini_set('memory_limit', '512M');
//ini_set('memory_limit', '3G');

//include_once 'BladeHelper.php';
END

sed -zi 's/\"autoload": {/"autoload": {\n        "files": ["app\/Helpers\/Helpers.php"], /' composer.json

composer dump-autoload

### Create Virtual
bash $BASEDIR/vhost.sh $projectName $projectName/public


