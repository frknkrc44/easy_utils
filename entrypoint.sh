#!/bin/bash

export FLUTTER_ROOT=/opt/flutter
export PUB_CACHE=/var/tmp/.pub_cache
export PATH=$PATH:$FLUTTER_ROOT/bin:$PUB_CACHE/bin
git config --global --add safe.directory $FLUTTER_ROOT

export JSON_OUTPUT=$(pana --no-warning --flutter-sdk $FLUTTER_ROOT $GITHUB_WORKSPACE --json)

export SUMMARY_CREATOR=$GITHUB_WORKSPACE/generate_pana_summary.sh
chmod +x $SUMMARY_CREATOR
bash -c $SUMMARY_CREATOR >> $GITHUB_STEP_SUMMARY

