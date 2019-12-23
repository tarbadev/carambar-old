#!/usr/bin/env bash
set -e
set -x

git clone --branch v1.12.13+hotfix.5 --depth 1 https://github.com/flutter/flutter.git
./flutter/bin/flutter doctor