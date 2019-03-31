#!/usr/bin/env bash
set -e
set -x

echo no | android create avd --force -n test -k "system-images;android-28;google_apis;x86"
emulator -avd test -no-audio -no-window &
android-wait-for-emulator