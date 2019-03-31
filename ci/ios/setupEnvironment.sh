#!/usr/bin/env bash
set -e

pip install six
brew update
brew install --HEAD usbmuxd
brew unlink usbmuxd
brew link usbmuxd
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy