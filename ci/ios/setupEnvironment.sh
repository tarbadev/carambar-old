#!/usr/bin/env bash
set -e
set -x

brew update
brew install --HEAD usbmuxd
brew unlink usbmuxd && brew link usbmuxd
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy
pod setup

open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/