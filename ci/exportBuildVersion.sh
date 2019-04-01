#!/usr/bin/env bash

git clone --depth 1 https://github.com/fsaintjacques/semver-tool /tmp/semver &> /dev/null
lastVersion=`git show origin/version:latest.txt`
export VERSION=`/tmp/semver/src/semver bump build ${TRAVIS_BUILD_NUMBER} ${lastVersion}`