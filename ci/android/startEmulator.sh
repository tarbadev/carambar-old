#!/usr/bin/env bash
set -e
set -x

echo no | android create avd --force -n test -t android-25 --abi google_apis/armeabi-v7a
emulator -avd test -no-window &
android-wait-for-emulator