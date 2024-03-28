#!/bin/bash

export FLUTTER_ROOT=/opt/flutter
export PUB_CACHE=/var/tmp/.pub_cache
export PATH=$FLUTTER_ROOT/bin:$PUB_CACHE/bin:$PATH
export CI=true
flutter --disable-analytics

git config --global --add safe.directory '*'
chown $(id -u):$(id -g) -R $GITHUB_WORKSPACE
ls -alh $GITHUB_WORKSPACE
export JSON_OUTPUT=$(pana --no-warning --flutter-sdk $FLUTTER_ROOT $GITHUB_WORKSPACE --json)

export SUMMARY_CREATOR=$GITHUB_WORKSPACE/generate_pana_summary.sh
chmod +x $SUMMARY_CREATOR
bash -c $SUMMARY_CREATOR >> $GITHUB_STEP_SUMMARY

