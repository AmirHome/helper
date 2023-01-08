#!/usr/bin/env bash

#!/bin/bash

# Check for the -apk argument (optional)

build_apk=0

# Use getopts to process the optional apk argument
while getopts ":a" opt; do
  case $opt in
    a)
      build_apk=1
      shift
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Shift the processed arguments to the left
shift $((OPTIND -1))

# Check if Flutter is installed
if ! [ -x "$(command -v flutter)" ]; then
  echo 'Error: Flutter is not installed.' >&2
  exit 1
fi

# Check if the Android SDK is installed and setup
#if ! [ -x "$(command -v adb)" ]; then
#  echo 'Error: Android SDK is not installed or not setup properly.' >&2
#  exit 1
#fi

# Check if the build name and build number are provided as arguments
#if [ $# -lt 2 ]; then
#  echo "Usage: $0 BUILD_NAME BUILD_NUMBER" >&2
#  exit 1
#fi

#build_name=$1
#build_number=$2

# Build the app for release
flutter pub upgrade
flutter format .

# Clean the project and get the packages
flutter clean
flutter pub get

# Now you can use the $apk variable to check if the apk argument was provided
if [ $build_apk -eq 1 ]; then

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


