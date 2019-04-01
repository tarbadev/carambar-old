#!/usr/bin/env bash
set -e
set -x

./flutter/bin/flutter emulators
./flutter/bin/flutter emulators --create --name=test
./flutter/bin/flutter emulators
./flutter/bin/flutter emulators --launch --name=test

echo no | android create avd --force -n test -t android-16 --abi google_apis/armeabi-v7a
#emulator -avd test -no-window --no-audio &
#android-wait-for-emulator