#!/usr/bin/env bash
set -e
set -x

git clone --branch v1.12.13+hotfix.5 --depth 1 https://github.com/flutter/flutter.git
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH=$PWD/flutter/bin:$PWD/flutter/bin/cache/dart-sdk/bin:$PATH
flutter doctor -v