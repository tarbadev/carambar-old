#!/usr/bin/env bash

git clone --branch version --depth 1 https://github.com/tarbadev/carambar.git
git clone --depth 1 https://github.com/fsaintjacques/semver-tool /tmp/semver &> /dev/null
lastVersion=`cat version/latest.txt`
export VERSION=`/tmp/semver/src/semver bump build ${TRAVIS_BUILD_NUMBER} ${lastVersion}`