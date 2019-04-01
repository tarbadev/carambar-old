#!/usr/bin/env bash
set -e
set -x

echo no | android create avd --force -n test -t android-26
emulator -avd test -no-audio -no-window &
android-wait-for-emulator