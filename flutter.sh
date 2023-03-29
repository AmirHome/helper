#!/bin/bash

while [ "$1" != "" ]; do
    case $1 in
        -r | -R )           shift
                            run_flag=1
                            ;;
        --apk )             shift
                            apk_flag=1
                            ;;
        * )                 break
    esac
    shift
done

# continue to execute other commands here if no flags were set

# Check if Flutter is installed
if ! [ -x "$(command -v flutter)" ]; then
  echo 'Error: Flutter is not installed.' >&2
  exit 1
fi

# commands to run when -r or -R flag is set
if [ "$run_flag" == 1 ]; then
    ### Clean the project and get the packages
    flutter pub cache clean
fi

echo "Flutter version: $(flutter --version)"

flutter channel stable

echo "Flutter upgrading..."
flutter upgrade

echo "Flutter cache repairing..."
flutter pub cache repair

### Clean the project and get the packages
echo "Flutter pub outdated running..."
flutter pub outdated

### Clean the project and get the packages
echo "Flutter cleaning..."
flutter clean


if [ -f "pubspec.lock" ]; then
  rm pubspec.lock
else
  echo "pubspec.lock does not exist"
fi

echo "Flutter upgrading packages..."
# flutter pub upgrade
flutter pub upgrade --null-safety

echo "Flutter getting packages..."
flutter pub get

echo "Flutter analyzing outdating..."
flutter pub outdated
# flutter pub upgrade --major-versions

# Build the app for release
# commands to run when --apk flag is set
if [ "$apk_flag" == 1 ]; then
    
    # Set the build mode to release
    flutter build apk --release

    # Check if the build was successful
    if [ $? -ne 0 ]; then
    echo 'Error: Build failed.' >&2
    exit 1
    fi

    # Get the APK file
    apk_file=$(find build/app/outputs/apk/release/ -name "*.apk")

    # Verify the APK file
    apksigner verify --print-certs "$apk_file"

    if [ $? -ne 0 ]; then
    echo 'Error: APK file is not properly signed.' >&2
    exit 1
    fi

    echo "Release APK: $apk_file"
fi