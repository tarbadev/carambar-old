#!/usr/bin/env bash
set -e
set -x

pip install six
brew update
brew install --HEAD usbmuxd
brew unlink usbmuxd && brew link usbmuxd
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy
pod setup

xcrun simctl list
open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/